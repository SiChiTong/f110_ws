#!/usr/bin/env python

import rospy
from race.msg import drive_param
from geometry_msgs.msg import PoseStamped
import math
import numpy as np
from numpy import linalg as LA
from tf.transformations import euler_from_quaternion, quaternion_from_euler
import csv
import os
import pdb

LOOKAHEAD_DISTANCE = 3.0 # meters
velocity = 1.5 # m/s
	
# import waypoints.csv into a list
dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../waypoints/levine-waypoints.csv')
with open(filename) as f:
	path_points = [tuple(line) for line in csv.reader(f)]
		
pub = rospy.Publisher('drive_parameters', drive_param, queue_size=0)


def callback(data):
	
	# 1. Determine the current location of the vehicle (we are subscribed to vesc/odom)
	print " "
	quaternion = (
		data.pose.orientation.x,
		data.pose.orientation.y,
		data.pose.orientation.z,
		data.pose.orientation.w
	)
	euler = euler_from_quaternion(quaternion)
	x = data.pose.position.x
	y = data.pose.position.y
	roll, pitch, yaw = euler[0], euler[1], euler[2]
	print "x:", x
	print "y:", y
	print "yaw:", yaw

	# 2. Find the path point closest to the vehicle
	# Index from end of the list and say, is this point close enough. And keep going
	# until one of those waypoints that is say, less than, 2 meters from you.
	# Trick: Once initialized, can just look at indices +- 10 from where current index is.
	# Vehicle should steer towards closest point one lookahead distance from its current location.
	for point in reversed(path_points):
		# Calculate distance between (x,y) and (point_x, point_y)
		point_x = float(point[0])
		point_y = float(point[1])
		dist = np.sqrt((x-point_x)**2 + (y-point_y)**2)
		if dist <= LOOKAHEAD_DISTANCE:
			break
		
	# At this point we should have found the goal point.
	
	# 3. Find the goal point.
	goal_point = point
	print "goal point:", point_x, point_y
	# 4. Transform the goal point to vehicle coordinates. 
	# Vehicle local coordinates probably need to be rotated by quaternion orientation.
	print "dist:", dist

	# theta should be minimum of yaw and math.pi/2 - yaw
	theta = yaw # theta is car's heading relative to world origin x axis in radians (initially is 0)
	# beta = abs(math.atan2((point_x - x), (point_y - y))) # direction in radians to goal point in world coordinates
	beta = math.atan2((point_x - x), (point_y - y))
	gamma = math.pi / 2 - theta - beta # direction in radians to goal point in car's local coordinates where positive gamma is left and negative gamma is right

	print "theta:", theta
	print "beta:", beta
	print "gamma:", gamma

	point_x_wrt_car = dist * math.sin(gamma) * -1.0
	point_y_wrt_car = dist * math.cos(gamma)

	print "point x wrt car:", point_x_wrt_car
	print "point y wrt car:", point_y_wrt_car

	# 5. Calculate the curvature.
	# The curvature is transformed into steering wheel angle by the vehicle on board controller.
	# curvature = 1/r = 2x/l^2
	angle = 2 * point_x_wrt_car / dist**2
	angle = -1.0 * angle # need to flip signage since negative angle goes right
	print "angle:", angle

	# 6. Update the vehicle's position. This is basically fetching the next subscription /vesc/odom. [DONE]

	print "Velocity", velocity
	print "Angle in Degrees", angle*180/np.pi

	if angle > 0.5236: # 0.5236 radians = 30 degrees
		print "Left steering angle too large!"
		angle = 0.5236
	if angle < -0.5236:
		print "Right steering angle too large!"
		angle = -0.5236

#	pdb.set_trace()

	msg = drive_param()
	msg.velocity = velocity
	msg.angle = angle
	pub.publish(msg)
	
if __name__ == '__main__':
	rospy.init_node('pure_pursuit')
	rospy.Subscriber('/pf/viz/inferred_pose', PoseStamped, callback)
	rospy.spin()

