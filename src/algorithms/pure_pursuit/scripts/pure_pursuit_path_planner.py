#!/usr/bin/env python

import rospy
from race.msg import drive_param
from geometry_msgs.msg import PoseStamped
from nav_msgs.msg import Path
import math
import numpy as np
from numpy import linalg as LA
from tf.transformations import euler_from_quaternion, quaternion_from_euler
import csv
import os 
import pdb


#############
# CONSTANTS #
#############


# To decide where to go next, the car looks at the waypoint whose distance is just
# beyond the lookahead distance (that is, the waypoint with the smallest distance to
# the car that is greater than the lookahead distance).
#
# Lookahead distance is dynamically adjusted based on how many points in front of
# the car are to the left or right of the car's y-axis, which determines whether the
# car will be making a turn (and if so, how much). The actual speed is computed
# as a linearly interpolated value between LOOKAHEAD_DISTANCE_STRAIGHT (the max.
# distance) and LOOKAHEAD_DISTANCE_TURN (the min. distance). 
# 
# Using this algorithm, if the car isn't turning at all (no points to its left or
# right), its lookahead distance will be LOOKAHEAD_DISTANCE_STRAIGHT, and if it is
# turning very steeply (lots of points to the left or right), its lookahead distance
# will be LOOKAHEAD_DISTANCE_TURN. If the curve the car is entering is neither shallow nor
# sharp, the lookahead distance will lie between these extremes.
#
# Note: these lookahead distances should be adjusted based on the speed the car is
# going at. Higher speeds will usually require greater lookahead distances
LOOKAHEAD_DISTANCE_STRAIGHT = 0.5 # meters   # 6.5
LOOKAHEAD_DISTANCE_TURN = 0.5               # 1.5

# Like lookahead distance, velocity is dynamically adjusted based on how much the car
# will turn. It is linearly interpolated between VELOCITY_STRAIGHT and VELOCITY_TURN.
VELOCITY_STRAIGHT = 0.5 # m/s                # 6.5
VELOCITY_TURN = 0.5                      # 2.0

# WP_TURN_WINDOW_MIN and WP_TURN_WINDOW_MAX define the window (ring) of points around the car
# which the car uses to determine how much it will need to turn. The car computes an
# average of the x-coordinates of the points within this window and linearly interpolates
# the required speed and lookahead distance based on this average value.
WP_TURN_WINDOW_MIN = 5.5                          # 5.5
WP_TURN_WINDOW_MAX = 6.0                          # 6.0

# When the car gets to the waypoint indexed by WP_LIST_END_THRESHOLD or beyond, it will
# reset current_index to 0, allowing the car to do loops around the track.
# The car may skip over waypoints at the very end of the list because it only considers
# waypoints that are *beyond* the lookahead distance.
# This is why we can't just check if the current index is equal to the length of the
# waypoint list minus 1.
WP_LIST_END_THRESHOLD = 50                   # 50

# Maximum average distance considered when computing the average distance of points
# from the car's y-axis.
# Any average value beyond this gets clipped for the purpose of determining whether the 
# car is making a turn.
MAX_WP_X_OFFSET = 5.5                        # 5.5

CURRENT_INDEX_FORWARD_THRESHOLD = 100


# for nav_msgs/Path:
# msg.poses -> array of poses
# msg.poses[i].pose.position.{x, y, z}
# msg.poses[i].pose.orientation.{x, y, z, w}

# Downsampling factor to bring the number of messages in


###########
# GLOBALS #
###########


# Index to start at when iterating through the points.
# This advances as the car drives around the track and is used so that we don't
# have to search starting from the beginning of the list every time (which would
# be very computationally expensive).
current_index = 0

# Have we found the closest point (and thus initialized current_index)?
found_closest_point = False

# import waypoints.csv into a list (path_points)
dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../waypoints/levine-waypoints.csv')
with open(filename) as f:
    path_points = [tuple(line) for line in csv.reader(f)]

# Turn path_points into a list of floats to eliminate the need for casts in the code below.
path_points = [(float(point[0]), float(point[1]), float(point[2])) for point in path_points]
        
# Publisher for 'drive_parameters' (speed and steering angle)
pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)


# Current global plan computed by global_planner.
current_plan = []


#############
# FUNCTIONS #
#############


# Finds the closest point to the car.
# This is used to initially set current_index upon startup, allowing the car 
# to start from anywhere, as long as its initial pose is set properly.
def get_index_of_closest_point(car_pos, current_plan):
    closest_index = 0
    closest_dist = float('inf')
    for index, pose in enumerate(current_plan):
        dist_to_point = dist(car_pos, pose.pose.position)
        if dist_to_point <= closest_dist:
            closest_dist = dist_to_point
            closest_index = index
    return closest_index

def update_current_index(car_pos, current_plan):
    global current_index
    
    max_index = np.clip(current_index + CURRENT_INDEX_FORWARD_THRESHOLD, 0, len(current_plan) - 1)
    
    closest_index = 0
    closest_dist = float('inf')
    for index, pose in enumerate(current_plan[current_index:max_index]):
        dist_to_point = dist(car_pos, pose.pose.position)
        if dist_to_point <= closest_dist:
            closest_dist = dist_to_point
            closest_index = index
    current_index = closest_index
    
# Computes the Euclidean distance between two 2D points p1 and p2.
def dist(p1, p2):
    return np.sqrt((p1[0] - p2.x) ** 2 + (p1[1] - p2.y) ** 2)

# Gets the average x-coordinate of points in front of the car within the
# circular window (ring) between WP_TURN_WINDOW_MIN and WP_TURN_WINDOW_MAX.
def get_avg_x_wrt_car(car_pos, current_plan, yaw):

    global current_index

    # Only consider waypoints within the window between WP_TURN_WINDOW_MIN
    # and WP_TURN_WINDOW_MAX.
    # We can think of this window as a ring of points around the car.

    car_x = car_pos[0]
    car_y = car_pos[1]
    avg_x_wrt_car = 0.0
    window_cnt = 0
    
    avg_x_start_behind_offset = 0 # 500
    
    avg_x_start_index = current_index - avg_x_start_behind_offset
    avg_x_start_index = np.clip(avg_x_start_index, 0, len(current_plan) - 1) 
    
    #print "avg x start index: ", avg_x_start_index
    
    # index here starts at 0
    for index, pose in enumerate(current_plan[avg_x_start_index:]):
        # Calculate distance between (x,y) and (point_x, point_y)
        point = pose.pose.position
        point_x = point.x
        point_y = point.y
        dist_to_point = dist(car_pos, point)
        
        if dist_to_point >= WP_TURN_WINDOW_MIN and dist_to_point <= WP_TURN_WINDOW_MAX:
            window_cnt += 1
            # For every point within the window, determine its absolute x-coordinate
            # relative to the car and compute an average over these x-coordinates.

            theta = yaw
            beta = math.atan2((point_x - car_x), (point_y - car_y))
            gamma = math.pi / 2 - theta - beta
            point_x_wrt_car = dist_to_point * math.sin(gamma) * -1.0
            avg_x_wrt_car += point_x_wrt_car

        # if point is in front of the car
        elif dist_to_point >= WP_TURN_WINDOW_MAX and index > avg_x_start_behind_offset:
            break  # points are in sorted order - no more to examine

        

    #print "window count: ", window_cnt
    
    # Edge case - no points within the window.
    if window_cnt == 0:
        return 0.0

    avg_x_wrt_car /= window_cnt

    #print "avg x wrt car: ", avg_x_wrt_car
    return avg_x_wrt_car

# Callback for the topic '/move_base/TrajectoryPlannerROS/global_plan'
# Updates the global plan when a new one is available so the car can continue
# to avoid obstacles.
def global_plan_callback(data):
    global current_plan
    current_plan = data.poses
    print 'Got new global plan. Length = ', len(current_plan)

# Callback for the topic '/pf/viz/inferred_pose'.
# Runs pure pursuit and speed control code.
def callback(data):
    
    global current_index # index of the waypoint that is closest to the car
    global found_closest_point
    global current_plan

    # Don't do anything if we haven't made a plan yet.
    if len(current_plan) == 0:
        print 'Nonexistent current plan'
        return

    # If current_index is within WP_LIST_END_THRESHOLD of the end of path_points,
    # then reset current_index to 0.
    # This allows the car to keep running when it gets to the end of the list.
    #if len(path_points) - current_index <= WP_LIST_END_THRESHOLD:
    #        current_index = 0

    # 1. Determine the current location of the vehicle (we are subscribed to vesc/odom)
    #print " "
    quaternion = (
        data.pose.orientation.x,
        data.pose.orientation.y,
        data.pose.orientation.z,
        data.pose.orientation.w
    )
    euler = euler_from_quaternion(quaternion)
    x = data.pose.position.x
    y = data.pose.position.y
    #print("x:", x)
    #print("y:", y)
    car_pos = (float(x), float(y))
    roll, pitch, yaw = euler[0], euler[1], euler[2]

    # Get the closest point to the car (if we haven't already) 
    # The reason we can't do this initialization step in main() (or when we read the
    # waypoints) is because we don't know the car's position until we're in the callback.
    current_index = get_index_of_closest_point(car_pos, current_plan)
    print 'Closest point index: ', current_index


    # Determine how gradually or sharply the car will be turning soon, if at all, by
    # computing the average x-coordinate of points within the car's search window defined
    # by WP_TURN_WINDOW_MIN and WP_TURN_WINDOW_MAX.
    # This average distance is used to compute its velocity and lookahead distance.
    avg_x_wrt_car = np.clip(abs(get_avg_x_wrt_car(car_pos, current_plan, yaw)), 0.0, MAX_WP_X_OFFSET)


    # Based on how much supposed to turn, lower the velocity and lookahead
    # distance to safer values via linear interpolation.
    velocity = np.interp(avg_x_wrt_car, [0.0, MAX_WP_X_OFFSET], [VELOCITY_STRAIGHT, VELOCITY_TURN])
    lookahead_distance = np.interp(avg_x_wrt_car, [0.0, MAX_WP_X_OFFSET], [LOOKAHEAD_DISTANCE_STRAIGHT, LOOKAHEAD_DISTANCE_TURN])
#    if avg_x_wrt_car > 1.5:
#        velocity = VELOCITY_TURN
#        lookahead_distance = LOOKAHEAD_DISTANCE_TURN
#    else:
#        velocity = VELOCITY_STRAIGHT
#        lookahead_distance = LOOKAHEAD_DISTANCE_STRAIGHT
    
    #print "Computed velocity: ", velocity
    #print "Computed lookahead distance: ", lookahead_distance
        

    # 2. Find the path point closest to the vehicle
    # Index from end of the list and say, is this point close enough. And keep going
    # until one of those waypoints that is say, less than, 2 meters from you.
    # Trick: Once initialized, can just look at indices +- 10 from where current index is.
    # Vehicle should steer towards closest point one lookahead distance from its current location.
    for index, pose in enumerate(current_plan[current_index:]):
        # Calculate distance between (x,y) and (point_x, point_y)
        dist_to_point = dist(car_pos, pose.pose.position)
        if dist_to_point >= lookahead_distance:
            # When we reach this, point is the goal point that the car wants to pure pursuit towards.
            break

    # 3. Transform the goal point to vehicle coordinates. 
    # Vehicle local coordinates probably need to be rotated by quaternion orientation.
    point = pose.pose.position
    point_x = point.x
    point_y = point.y

    # theta should be minimum of yaw and math.pi/2 - yaw
    theta = yaw # theta is car's heading relative to world origin x axis in radians (initially is 0)
    beta = math.atan2((point_x - x), (point_y - y))
    gamma = math.pi / 2 - theta - beta # direction in radians to goal point in car's local coordinates where positive gamma is left and negative gamma is right

    point_x_wrt_car = dist_to_point * math.sin(gamma) * -1.0
    point_y_wrt_car = dist_to_point * math.cos(gamma)

    # 4. Calculate the curvature.
    # The curvature is transformed into steering wheel angle by the vehicle on board controller.
    # curvature = 1/r = 2x/l^2
    angle = 2 * point_x_wrt_car / dist_to_point**2
    angle = -1.0 * angle # need to flip signage since negative angle goes right

    # 5. Update the vehicle's position. This is basically fetching the next subscription /vesc/odom. [DONE
    #print "Angle in Degrees", angle*180/np.pi
    angle = np.clip(angle, -0.4189, 0.4189) # 0.4189 radians = 24 degrees because car can only turn 24 degrees max
    #print "Current Index of Car: ", current_index
    
    #if current_index > 500:
    #    pdb.set_trace()
    
    #update_current_index(car_pos, current_plan)

#    pdb.set_trace()

    msg = drive_param()
    msg.velocity = velocity
    msg.angle = angle
    pub.publish(msg)
    
if __name__ == '__main__':
    rospy.init_node('pure_pursuit')
    rospy.Subscriber('/pf/viz/inferred_pose', PoseStamped, callback, queue_size=1)
    rospy.Subscriber('/move_base/TrajectoryPlannerROS/global_plan', Path, global_plan_callback, queue_size=1)
    rospy.spin()

