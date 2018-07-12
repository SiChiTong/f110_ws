#!/usr/bin/env python

import rospy
from race.msg import drive_param
from nav_msgs.msg import Odometry
import numpy as np

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)

def control(data):

	velocity = 0.5 # meters per second
	angle_in_degrees = 30
	angle = angle_in_degrees * np.pi / 180

	print "Velocity", velocity
	print "Angle in Degrees", angle_in_degrees

	msg = drive_param()
	msg.velocity = velocity
	msg.angle = angle
	pub.publish(msg)

def listener():
	rospy.init_node('pid_controller', anonymous=True)
	rospy.Subscriber("vesc/odom", Odometry, control)
	rospy.spin()


if __name__ == '__main__':
	print("Going in circle")
	listener()
