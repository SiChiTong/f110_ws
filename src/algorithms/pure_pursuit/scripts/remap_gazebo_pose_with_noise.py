#!/usr/bin/env python

import rospy
import numpy as np
import numpy.random as rand
import tf
from race.msg import drive_param
from geometry_msgs.msg import PoseStamped, Pose
from gazebo_msgs.msg import ModelStates
from gazebo_msgs.srv import GetModelState
from std_msgs.msg import Header

pub = rospy.Publisher("pf/viz/inferred_pose", PoseStamped, queue_size=1)

POSE_XY_VARIANCE = 1.0
POSE_ROTATION_VARIANCE = 0.1
racecar_pose = Pose()

# Adds Guassian noise to the car's pose.
# Noise is added separately to XY position (with variance POSE_XY_VARIANCE)
# and rotation (with variance POSE_ROTATION_VARIANCE).
def add_noise_to_pose(pose):

    pose.position.x += rand.normal(0, POSE_XY_VARIANCE, 1)
    pose.position.y += rand.normal(0, POSE_XY_VARIANCE, 1)

    pose.orientation.x += rand.normal(0, POSE_ROTATION_VARIANCE, 1)
    pose.orientation.y += rand.normal(0, POSE_ROTATION_VARIANCE, 1)
    pose.orientation.z += rand.normal(0, POSE_ROTATION_VARIANCE, 1)
    pose.orientation.w += rand.normal(0, POSE_ROTATION_VARIANCE, 1)

    return pose
    
def timer_callback(event):
    global racecar_pose
    msg = PoseStamped()
    msg.pose = racecar_pose
    pub.publish(msg)

# Gets the racecar pose from gazebo/model_states topic. Since Gazebo has multiple
# models (racecar, ground plane) we have to index for the "racecar".
def robot_pose_update(data):
    global racecar_pose
    names = data.name
    # Break out of this callback if racecar not properly initialized in Gazebo yet so that we don't see red error statements in Terminal about no index of "racecar" in names.
    if len(names) < 2:
        return
    racecar_index = names.index("racecar")
    racecar_pose = data.pose[racecar_index]

    # Add some Gaussian noise to the car's pose (the ground truth data).
    # racecar_pose = add_noise_to_pose(racecar_pose)

if __name__ == "__main__":
    rospy.init_node("remap_gazebo_pose")
    # Set the update rate
    rospy.Timer(rospy.Duration(.025), timer_callback) # 40hz
    # Set subscribers
    rospy.Subscriber("gazebo/model_states", ModelStates, robot_pose_update)
    rospy.spin()
