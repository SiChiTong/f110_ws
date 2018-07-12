#!/usr/bin/env python

import rospy
from race.msg import drive_param
from race.msg import pid_input
import numpy as np

pub = rospy.Publisher('drive_parameters', drive_param, queue_size=1)

kp = 10.
kd = 0.01
ki = 0.0
servo_offset = 0.0
prev_error = 0.0 
error = 0.0
integral = 0.0


def control(data):
	global integral
	global prev_error
	global kp
	global ki
	global kd
	velocity = data.pid_vel
	angle = servo_offset
	error = 5*data.pid_error
	
	print "Error Control", error
	if error!=0.0:	
		# Optional, we can add ki*integral at the end of control_error.
		control_error = kp*error + kd*(error - prev_error)
		print "Control", control_error
		angle = angle + control_error*np.pi/180

	prev_error = error

	# Limits steering angle to 30 degrees b/c Traxxas car can only turn 30 degrees
	if angle > 30*np.pi/180:
		angle = 30*np.pi/180
	if angle < -30*np.pi/180:
		angle = -30*np.pi/180

	# Slows down car when making a turn.
	if angle >= 10*np.pi/180 or angle <= -10*np.pi/180:
		velocity = 1.0
		
	if angle > 20*np.pi/180 or angle < -20*np.pi/180:
		velocity = 0.5

	# Speeds up car to 10.0 if going pretty straight.
	if angle >= -1*np.pi/180 and angle <= 1*np.pi/180:
		velocity = 2.0

	print "Velocity", velocity
	print "Angle in Degrees", angle*180/np.pi

	msg = drive_param()
	msg.velocity = velocity
	msg.angle = angle
	pub.publish(msg)

def listener():
	rospy.init_node('pid_controller', anonymous=True)
	rospy.Subscriber("error", pid_input, control)
	rospy.spin()


if __name__ == '__main__':
	print("Listening to error for PID")
	listener()
