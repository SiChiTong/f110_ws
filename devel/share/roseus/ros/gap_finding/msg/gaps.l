;; Auto-generated. Do not edit!


(when (boundp 'gap_finding::gaps)
  (if (not (find-package "GAP_FINDING"))
    (make-package "GAP_FINDING"))
  (shadow 'gaps (find-package "GAP_FINDING")))
(unless (find-package "GAP_FINDING::GAPS")
  (make-package "GAP_FINDING::GAPS"))

(in-package "ROS")
;;//! \htmlinclude gaps.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gap_finding::gaps
  :super ros::object
  :slots (_header _gaps ))

(defmethod gap_finding::gaps
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:gaps __gaps) (let (r) (dotimes (i 0) (push (instance gap_finding::Gap :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _gaps __gaps)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:gaps
   (&rest __gaps)
   (if (keywordp (car __gaps))
       (send* _gaps __gaps)
     (progn
       (if __gaps (setq _gaps (car __gaps)))
       _gaps)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; gap_finding/Gap[] _gaps
    (apply #'+ (send-all _gaps :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; gap_finding/Gap[] _gaps
     (write-long (length _gaps) s)
     (dolist (elem _gaps)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; gap_finding/Gap[] _gaps
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _gaps (let (r) (dotimes (i n) (push (instance gap_finding::Gap :init) r)) r))
     (dolist (elem- _gaps)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get gap_finding::gaps :md5sum-) "7c433d339b96f265e8d4af6ca8e2dbd8")
(setf (get gap_finding::gaps :datatype-) "gap_finding/gaps")
(setf (get gap_finding::gaps :definition-)
      "Header header
Gap[] gaps

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

================================================================================
MSG: gap_finding/Gap
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

")



(provide :gap_finding/gaps "7c433d339b96f265e8d4af6ca8e2dbd8")


