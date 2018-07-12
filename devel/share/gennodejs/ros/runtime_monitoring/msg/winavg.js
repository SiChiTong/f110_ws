// Auto-generated. Do not edit!

// (in-package runtime_monitoring.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class winavg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.avg = null;
      this.windowsize = null;
    }
    else {
      if (initObj.hasOwnProperty('avg')) {
        this.avg = initObj.avg
      }
      else {
        this.avg = 0.0;
      }
      if (initObj.hasOwnProperty('windowsize')) {
        this.windowsize = initObj.windowsize
      }
      else {
        this.windowsize = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type winavg
    // Serialize message field [avg]
    bufferOffset = _serializer.float64(obj.avg, buffer, bufferOffset);
    // Serialize message field [windowsize]
    bufferOffset = _serializer.int32(obj.windowsize, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type winavg
    let len;
    let data = new winavg(null);
    // Deserialize message field [avg]
    data.avg = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [windowsize]
    data.windowsize = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'runtime_monitoring/winavg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ee07ea8681a58f4616a5f3928b9086e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 avg
    int32 windowsize
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new winavg(null);
    if (msg.avg !== undefined) {
      resolved.avg = msg.avg;
    }
    else {
      resolved.avg = 0.0
    }

    if (msg.windowsize !== undefined) {
      resolved.windowsize = msg.windowsize;
    }
    else {
      resolved.windowsize = 0
    }

    return resolved;
    }
};

module.exports = winavg;
