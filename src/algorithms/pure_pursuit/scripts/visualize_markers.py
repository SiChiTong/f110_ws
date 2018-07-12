#!/usr/bin/env python

import roslib; roslib.load_manifest('visualization_marker_tutorials')
from visualization_msgs.msg import Marker
from visualization_msgs.msg import MarkerArray
import rospy
import math

import os
import csv

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../waypoints/mlab-inside-waypoints.csv')
with open(filename) as f:
	path_points = [tuple(line) for line in csv.reader(f)]

topic = 'visualization_marker_array'
publisher = rospy.Publisher(topic, MarkerArray)

rospy.init_node('register')

markerArray = MarkerArray()

while not rospy.is_shutdown():
	for point in path_points:
		x = float(point[0])
		y = float(point[1])
		marker = Marker()
		marker.header.frame_id = "/map"
		marker.type = marker.SPHERE
		marker.action = marker.ADD
		marker.scale.x = 0.1
		marker.scale.y = 0.1
		marker.scale.z = 0.1
		marker.color.a = 1.0
		marker.color.r = 1.0
		marker.color.g = 1.0
		marker.color.b = 0.0
		marker.pose.orientation.w = 1.0
		marker.pose.position.x = x
		marker.pose.position.y = y
		marker.pose.position.z = 0

		markerArray.markers.append(marker)

	# Renumber the marker IDs
	id = 0
	for m in markerArray.markers:
		m.id = id
		id += 1

	# Publish the MarkerArray
	publisher.publish(markerArray)

	rospy.sleep(0.01)
