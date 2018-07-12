#!/usr/bin/env python

import rospy
import math
import numpy as np
import yaml
import sys
from sensor_msgs.msg import LaserScan
from race.msg import pid_input
import pdb

# These are turn instructions for Levine 2nd floor loop, counter-clockwise starting at mLab
TURN_INSTRUCTIONS = ["left", "left", "left", "center", "left", "center"]
#TURN_INSTRUCTIONS = loadYAML("/home/nvidia/Desktop/directions.yaml")

TURN_DELAY = 5 # number of seconds to wait before detecting next opening turns
OPENING_THRESHOLD = 0.75 # meters
ANGLE_RANGE = 270 # Hokuyo 10LX has 270 degrees scan
DESIRED_DISTANCE_RIGHT = 0.55 # meters
DESIRED_DISTANCE_LEFT = 0.55
VELOCITY = 2.00 # meters per second
CAR_LENGTH = 0.50 # Traxxas Rally is 20 inches or 0.5 meters

turn_instruction_index = 0
independence_time = 0 # This is the time in rospy seconds when the robot is free to detect its next opening
turn = "center" # initially robot is just going down straight
detectedOpening = False

pub = rospy.Publisher('error', pid_input, queue_size=10)

def loadYAML(fileLocation):
	with open(fileLocation) as stream:
	    try:
		return (yaml.load(stream))
	    except yaml.YAMLError as exc:
		return (exc)

# Takes in an angle between -45 to 225, where 0 degrees is directly to the right
# Outputs length in meters to object with angle in lidar scan.
def getRange(data,angle):
	if angle > 179.9:
		angle = 179.9
	index = len(data.ranges) * (angle + 45) / ANGLE_RANGE
	dist = data.ranges[int(index)]
	if math.isinf(dist):
		return 10.0
	if math.isnan(dist):
		return 4.0
	return data.ranges[int(index)]

def detectOpening(data):
	left, right, center = False, False, False
	if detectOpeningHelper(data, 20.0, 60.0):
		right = True
	if detectOpeningHelper(data, 120.0, 180.0):
		left = True
	if(left and right):
		return "leftandright"
	elif left:
		return "left"
	elif right:
		return "right"	
	else:
		return "none" 
	
# Helper method so we don't have duplicate code in detectOpening for left and right
def detectOpeningHelper(data, minAngle, maxAngle):
	for angle in np.arange(minAngle, maxAngle, .25):
		dist_1 = getRange(data, angle)
		dist_2 = getRange(data, angle + .25)
		ridiculous_distance_threshold = 40 # metal reflections give inaccurate distance measurements
		if dist_1 > 40 or dist_2 > 40:
			continue # skip iteration if sees metal reflection since not true opening
		if(abs(dist_1 - dist_2) > OPENING_THRESHOLD):
			return True
	return False

def followRight(data,desired_trajectory):
	global alpha

	a = getRange(data,60)
	b = getRange(data,0)
	swing = math.radians(60)
	alpha = math.atan((a*math.cos(swing)-b)/(a*math.sin(swing)))
	print "a","b", a, b
	print "Alpha right",math.degrees(alpha)
	curr_dist = b*math.cos(alpha)

	future_dist = curr_dist + CAR_LENGTH * math.sin(alpha)
	print "Right : ",future_dist
	error = desired_trajectory - future_dist

	print "Current Distance Right: ", curr_dist
	return error, curr_dist

def followLeft(data,desired_trajectory):
	global alpha

	a = getRange(data,120)
	b = getRange(data,179.9)
	swing = math.radians(60)
	print "a","b", a, b
	alpha = -math.atan((a*math.cos(swing)-b)/(a*math.sin(swing)))
	print "Alpha left",math.degrees(alpha)
	curr_dist = b*math.cos(alpha)
	
	future_dist = curr_dist - CAR_LENGTH * math.sin(alpha)
	print "Left : ",future_dist
	error = future_dist - desired_trajectory

	print "Current Distance Left: ", curr_dist
	return error, curr_dist
	
def followCenter(data):
	global alpha

	a = getRange(data,120)
	b = getRange(data,179.9)
	swing = math.radians(60)
	print "center distances: ", a, b
	alpha = -math.atan((a*math.cos(swing)-b)/(a*math.sin(swing)))
	print "Alpha left",math.degrees(alpha)
	curr_dist1 = b*math.cos(alpha)
	future_dist1 = curr_dist1-CAR_LENGTH*math.sin(alpha)

	a = getRange(data,60)
	b = getRange(data,0)
	swing = math.radians(60)
	alpha = math.atan((a*math.cos(swing)-b)/(a*math.sin(swing)))
	print "Alpha right",math.degrees(alpha)
	curr_dist2 = b*math.cos(alpha)
	future_dist2 = curr_dist2+CAR_LENGTH*math.sin(alpha)

	print "dist 1 : ",future_dist1
	print "dist 2 : ",future_dist2
	
	error = future_dist1 - future_dist2
	print "Error : ",error
	return error, curr_dist2 - curr_dist1

# Takes in turn which is either "left", "right", or "center" and outputs corresponding error
def followWallInDirection(turn, data):
	if (turn == "left"):
		error_left, curr_dist_left = followLeft(data, DESIRED_DISTANCE_LEFT)
		error = error_left
	elif (turn == "right"):
		error_right, curr_dist_right = followRight(data, DESIRED_DISTANCE_RIGHT)
		error = error_right
	elif(turn == "center"):
		error_center, curr_dist_center = followCenter(data)
		error = error_center
	return error

def callback(data):
	global error
	global alpha
	global flag_obstacle
	global final_desired_trajectory
	global final_direction
	global prev_direction

	global detectedOpening
	global independence_time # counter for number of callbacks remaining for this turn direction
	
	global turn
	global turn_instruction_index
	
	
	print " "

	detectedOpening = detectOpening(data) # For now just care if it is "none" or other
	print "Detected opening? ", detectedOpening
	
	current_time = rospy.get_time()
	print "Current Time:", current_time
	
	# Need to extrapolate all of this into a neater method so callback function is simple
	# Case where it's the first frame of detecting an opening
	if detectedOpening != "none" and current_time >= independence_time:
		# set independence_time to the full timer duration
		independence_time = TURN_DELAY + current_time
		turn = TURN_INSTRUCTIONS[turn_instruction_index]
		turn_instruction_index += 1 # so that next time detecting opening will call next instruction
	# Case where robot is free to move because it has already exceeded the previously set timer
	elif current_time >= independence_time:
		turn = "center"

	# Regardless of which case above, robot will be doing a wall follow (left, center, or right)
	error = followWallInDirection(turn, data)

	print "On turn instruction index:", turn_instruction_index - 1 # to counteract +1 before
	print "Independence Time", independence_time
	print "Turn: ", turn

	msg = pid_input()
	msg.pid_error = error
	msg.pid_vel = VELOCITY
	pub.publish(msg)


if __name__ == '__main__':
	print("Laser node started")
	rospy.init_node('dist_finder',anonymous = True)
	rospy.Subscriber("scan",LaserScan,callback)
	rospy.spin()
