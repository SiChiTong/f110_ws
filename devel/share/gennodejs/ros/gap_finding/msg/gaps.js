// Auto-generated. Do not edit!

// (in-package gap_finding.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Gap = require('./Gap.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class gaps {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.gaps = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('gaps')) {
        this.gaps = initObj.gaps
      }
      else {
        this.gaps = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type gaps
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [gaps]
    // Serialize the length for message field [gaps]
    bufferOffset = _serializer.uint32(obj.gaps.length, buffer, bufferOffset);
    obj.gaps.forEach((val) => {
      bufferOffset = Gap.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type gaps
    let len;
    let data = new gaps(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [gaps]
    // Deserialize array length for message field [gaps]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.gaps = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.gaps[i] = Gap.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.gaps.forEach((val) => {
      length += Gap.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gap_finding/gaps';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7c433d339b96f265e8d4af6ca8e2dbd8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new gaps(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.gaps !== undefined) {
      resolved.gaps = new Array(msg.gaps.length);
      for (let i = 0; i < resolved.gaps.length; ++i) {
        resolved.gaps[i] = Gap.Resolve(msg.gaps[i]);
      }
    }
    else {
      resolved.gaps = []
    }

    return resolved;
    }
};

module.exports = gaps;
