# A gap computed from sensor_msgs/LaserScan message data

Header header

# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and 
# right boundary of the gap
float32 leftRange
float32 leftAngle
float32 rightRange
float32 rightAngle

# In the future it might be useful to also include the ranges in-between the left and right boundaries 
# in case that is used in the navigation algorithm.
