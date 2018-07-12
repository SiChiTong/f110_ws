; Auto-generated. Do not edit!


(cl:in-package runtime_monitoring-msg)


;//! \htmlinclude winavg.msg.html

(cl:defclass <winavg> (roslisp-msg-protocol:ros-message)
  ((avg
    :reader avg
    :initarg :avg
    :type cl:float
    :initform 0.0)
   (windowsize
    :reader windowsize
    :initarg :windowsize
    :type cl:integer
    :initform 0))
)

(cl:defclass winavg (<winavg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <winavg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'winavg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name runtime_monitoring-msg:<winavg> is deprecated: use runtime_monitoring-msg:winavg instead.")))

(cl:ensure-generic-function 'avg-val :lambda-list '(m))
(cl:defmethod avg-val ((m <winavg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader runtime_monitoring-msg:avg-val is deprecated.  Use runtime_monitoring-msg:avg instead.")
  (avg m))

(cl:ensure-generic-function 'windowsize-val :lambda-list '(m))
(cl:defmethod windowsize-val ((m <winavg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader runtime_monitoring-msg:windowsize-val is deprecated.  Use runtime_monitoring-msg:windowsize instead.")
  (windowsize m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <winavg>) ostream)
  "Serializes a message object of type '<winavg>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'avg))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'windowsize)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <winavg>) istream)
  "Deserializes a message object of type '<winavg>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'avg) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'windowsize) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<winavg>)))
  "Returns string type for a message object of type '<winavg>"
  "runtime_monitoring/winavg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'winavg)))
  "Returns string type for a message object of type 'winavg"
  "runtime_monitoring/winavg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<winavg>)))
  "Returns md5sum for a message object of type '<winavg>"
  "ee07ea8681a58f4616a5f3928b9086e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'winavg)))
  "Returns md5sum for a message object of type 'winavg"
  "ee07ea8681a58f4616a5f3928b9086e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<winavg>)))
  "Returns full string definition for message of type '<winavg>"
  (cl:format cl:nil "float64 avg~%int32 windowsize~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'winavg)))
  "Returns full string definition for message of type 'winavg"
  (cl:format cl:nil "float64 avg~%int32 windowsize~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <winavg>))
  (cl:+ 0
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <winavg>))
  "Converts a ROS message object to a list"
  (cl:list 'winavg
    (cl:cons ':avg (avg msg))
    (cl:cons ':windowsize (windowsize msg))
))
