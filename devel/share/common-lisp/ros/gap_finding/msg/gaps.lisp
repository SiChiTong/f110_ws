; Auto-generated. Do not edit!


(cl:in-package gap_finding-msg)


;//! \htmlinclude gaps.msg.html

(cl:defclass <gaps> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (gaps
    :reader gaps
    :initarg :gaps
    :type (cl:vector gap_finding-msg:Gap)
   :initform (cl:make-array 0 :element-type 'gap_finding-msg:Gap :initial-element (cl:make-instance 'gap_finding-msg:Gap))))
)

(cl:defclass gaps (<gaps>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gaps>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gaps)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gap_finding-msg:<gaps> is deprecated: use gap_finding-msg:gaps instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <gaps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:header-val is deprecated.  Use gap_finding-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'gaps-val :lambda-list '(m))
(cl:defmethod gaps-val ((m <gaps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:gaps-val is deprecated.  Use gap_finding-msg:gaps instead.")
  (gaps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gaps>) ostream)
  "Serializes a message object of type '<gaps>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'gaps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'gaps))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gaps>) istream)
  "Deserializes a message object of type '<gaps>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'gaps) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'gaps)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'gap_finding-msg:Gap))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gaps>)))
  "Returns string type for a message object of type '<gaps>"
  "gap_finding/gaps")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gaps)))
  "Returns string type for a message object of type 'gaps"
  "gap_finding/gaps")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gaps>)))
  "Returns md5sum for a message object of type '<gaps>"
  "7c433d339b96f265e8d4af6ca8e2dbd8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gaps)))
  "Returns md5sum for a message object of type 'gaps"
  "7c433d339b96f265e8d4af6ca8e2dbd8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gaps>)))
  "Returns full string definition for message of type '<gaps>"
  (cl:format cl:nil "Header header~%Gap[] gaps~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: gap_finding/Gap~%# A gap computed from sensor_msgs/LaserScan message data~%~%Header header~%~%# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and ~%# right boundary of the gap~%float32 leftRange~%float32 leftAngle~%float32 rightRange~%float32 rightAngle~%~%# In the future it might be useful to also include the ranges in-between the left and right boundaries ~%# in case that is used in the navigation algorithm.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gaps)))
  "Returns full string definition for message of type 'gaps"
  (cl:format cl:nil "Header header~%Gap[] gaps~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: gap_finding/Gap~%# A gap computed from sensor_msgs/LaserScan message data~%~%Header header~%~%# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and ~%# right boundary of the gap~%float32 leftRange~%float32 leftAngle~%float32 rightRange~%float32 rightAngle~%~%# In the future it might be useful to also include the ranges in-between the left and right boundaries ~%# in case that is used in the navigation algorithm.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gaps>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'gaps) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gaps>))
  "Converts a ROS message object to a list"
  (cl:list 'gaps
    (cl:cons ':header (header msg))
    (cl:cons ':gaps (gaps msg))
))
