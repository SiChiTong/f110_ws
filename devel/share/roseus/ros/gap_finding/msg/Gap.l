;; Auto-generated. Do not edit!


(when (boundp 'gap_finding::Gap)
  (if (not (find-package "GAP_FINDING"))
    (make-package "GAP_FINDING"))
  (shadow 'Gap (find-package "GAP_FINDING")))
(unless (find-package "GAP_FINDING::GAP")
  (make-package "GAP_FINDING::GAP"))

(in-package "ROS")
;;//! \htmlinclude Gap.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gap_finding::Gap
  :super ros::object
  :slots (_header _leftRange _leftAngle _rightRange _rightAngle ))

(defmethod gap_finding::Gap
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:leftRange __leftRange) 0.0)
    ((:leftAngle __leftAngle) 0.0)
    ((:rightRange __rightRange) 0.0)
    ((:rightAngle __rightAngle) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _leftRange (float __leftRange))
   (setq _leftAngle (float __leftAngle))
   (setq _rightRange (float __rightRange))
   (setq _rightAngle (float __rightAngle))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:leftRange
   (&optional __leftRange)
   (if __leftRange (setq _leftRange __leftRange)) _leftRange)
  (:leftAngle
   (&optional __leftAngle)
   (if __leftAngle (setq _leftAngle __leftAngle)) _leftAngle)
  (:rightRange
   (&optional __rightRange)
   (if __rightRange (setq _rightRange __rightRange)) _rightRange)
  (:rightAngle
   (&optional __rightAngle)
   (if __rightAngle (setq _rightAngle __rightAngle)) _rightAngle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _leftRange
    4
    ;; float32 _leftAngle
    4
    ;; float32 _rightRange
    4
    ;; float32 _rightAngle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _leftRange
       (sys::poke _leftRange (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _leftAngle
       (sys::poke _leftAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rightRange
       (sys::poke _rightRange (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rightAngle
       (sys::poke _rightAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _leftRange
     (setq _leftRange (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _leftAngle
     (setq _leftAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rightRange
     (setq _rightRange (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rightAngle
     (setq _rightAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get gap_finding::Gap :md5sum-) "bc7ab60870d0fcb9f6ec7084f4325f3a")
(setf (get gap_finding::Gap :datatype-) "gap_finding/Gap")
(setf (get gap_finding::Gap :definition-)
      "# A gap computed from sensor_msgs/LaserScan message data

Header header

# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and 
# right boundary of the gap
float32 leftRange
float32 leftAngle
float32 rightRange
float32 rightAngle

# In the future it might be useful to also include the ranges in-between the left and right boundaries 
# in case that is used in the navigation algorithm.

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

")



(provide :gap_finding/Gap "bc7ab60870d0fcb9f6ec7084f4325f3a")


