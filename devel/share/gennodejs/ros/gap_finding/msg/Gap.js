// Auto-generated. Do not edit!

// (in-package gap_finding.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class Gap {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.leftRange = null;
      this.leftAngle = null;
      this.rightRange = null;
      this.rightAngle = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('leftRange')) {
        this.leftRange = initObj.leftRange
      }
      else {
        this.leftRange = 0.0;
      }
      if (initObj.hasOwnProperty('leftAngle')) {
        this.leftAngle = initObj.leftAngle
      }
      else {
        this.leftAngle = 0.0;
      }
      if (initObj.hasOwnProperty('rightRange')) {
        this.rightRange = initObj.rightRange
      }
      else {
        this.rightRange = 0.0;
      }
      if (initObj.hasOwnProperty('rightAngle')) {
        this.rightAngle = initObj.rightAngle
      }
      else {
        this.rightAngle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Gap
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [leftRange]
    bufferOffset = _serializer.float32(obj.leftRange, buffer, bufferOffset);
    // Serialize message field [leftAngle]
    bufferOffset = _serializer.float32(obj.leftAngle, buffer, bufferOffset);
    // Serialize message field [rightRange]
    bufferOffset = _serializer.float32(obj.rightRange, buffer, bufferOffset);
    // Serialize message field [rightAngle]
    bufferOffset = _serializer.float32(obj.rightAngle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Gap
    let len;
    let data = new Gap(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [leftRange]
    data.leftRange = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [leftAngle]
    data.leftAngle = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rightRange]
    data.rightRange = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rightAngle]
    data.rightAngle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gap_finding/Gap';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bc7ab60870d0fcb9f6ec7084f4325f3a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Gap(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.leftRange !== undefined) {
      resolved.leftRange = msg.leftRange;
    }
    else {
      resolved.leftRange = 0.0
    }

    if (msg.leftAngle !== undefined) {
      resolved.leftAngle = msg.leftAngle;
    }
    else {
      resolved.leftAngle = 0.0
    }

    if (msg.rightRange !== undefined) {
      resolved.rightRange = msg.rightRange;
    }
    else {
      resolved.rightRange = 0.0
    }

    if (msg.rightAngle !== undefined) {
      resolved.rightAngle = msg.rightAngle;
    }
    else {
      resolved.rightAngle = 0.0
    }

    return resolved;
    }
};

module.exports = Gap;
