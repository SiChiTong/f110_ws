; Auto-generated. Do not edit!


(cl:in-package gap_finding-msg)


;//! \htmlinclude Gap.msg.html

(cl:defclass <Gap> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (leftRange
    :reader leftRange
    :initarg :leftRange
    :type cl:float
    :initform 0.0)
   (leftAngle
    :reader leftAngle
    :initarg :leftAngle
    :type cl:float
    :initform 0.0)
   (rightRange
    :reader rightRange
    :initarg :rightRange
    :type cl:float
    :initform 0.0)
   (rightAngle
    :reader rightAngle
    :initarg :rightAngle
    :type cl:float
    :initform 0.0))
)

(cl:defclass Gap (<Gap>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Gap>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Gap)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gap_finding-msg:<Gap> is deprecated: use gap_finding-msg:Gap instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:header-val is deprecated.  Use gap_finding-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'leftRange-val :lambda-list '(m))
(cl:defmethod leftRange-val ((m <Gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:leftRange-val is deprecated.  Use gap_finding-msg:leftRange instead.")
  (leftRange m))

(cl:ensure-generic-function 'leftAngle-val :lambda-list '(m))
(cl:defmethod leftAngle-val ((m <Gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:leftAngle-val is deprecated.  Use gap_finding-msg:leftAngle instead.")
  (leftAngle m))

(cl:ensure-generic-function 'rightRange-val :lambda-list '(m))
(cl:defmethod rightRange-val ((m <Gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:rightRange-val is deprecated.  Use gap_finding-msg:rightRange instead.")
  (rightRange m))

(cl:ensure-generic-function 'rightAngle-val :lambda-list '(m))
(cl:defmethod rightAngle-val ((m <Gap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gap_finding-msg:rightAngle-val is deprecated.  Use gap_finding-msg:rightAngle instead.")
  (rightAngle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Gap>) ostream)
  "Serializes a message object of type '<Gap>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leftRange))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'leftAngle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rightRange))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rightAngle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Gap>) istream)
  "Deserializes a message object of type '<Gap>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leftRange) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'leftAngle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rightRange) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rightAngle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Gap>)))
  "Returns string type for a message object of type '<Gap>"
  "gap_finding/Gap")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Gap)))
  "Returns string type for a message object of type 'Gap"
  "gap_finding/Gap")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Gap>)))
  "Returns md5sum for a message object of type '<Gap>"
  "bc7ab60870d0fcb9f6ec7084f4325f3a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Gap)))
  "Returns md5sum for a message object of type 'Gap"
  "bc7ab60870d0fcb9f6ec7084f4325f3a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Gap>)))
  "Returns full string definition for message of type '<Gap>"
  (cl:format cl:nil "# A gap computed from sensor_msgs/LaserScan message data~%~%Header header~%~%# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and ~%# right boundary of the gap~%float32 leftRange~%float32 leftAngle~%float32 rightRange~%float32 rightAngle~%~%# In the future it might be useful to also include the ranges in-between the left and right boundaries ~%# in case that is used in the navigation algorithm.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Gap)))
  "Returns full string definition for message of type 'Gap"
  (cl:format cl:nil "# A gap computed from sensor_msgs/LaserScan message data~%~%Header header~%~%# A gap is represented by 4 numbers: the ranges and angles (measured by the lidar) of the laser rays striking the left and ~%# right boundary of the gap~%float32 leftRange~%float32 leftAngle~%float32 rightRange~%float32 rightAngle~%~%# In the future it might be useful to also include the ranges in-between the left and right boundaries ~%# in case that is used in the navigation algorithm.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Gap>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Gap>))
  "Converts a ROS message object to a list"
  (cl:list 'Gap
    (cl:cons ':header (header msg))
    (cl:cons ':leftRange (leftRange msg))
    (cl:cons ':leftAngle (leftAngle msg))
    (cl:cons ':rightRange (rightRange msg))
    (cl:cons ':rightAngle (rightAngle msg))
))
