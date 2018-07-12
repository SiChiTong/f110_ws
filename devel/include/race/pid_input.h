// Generated by gencpp from file race/pid_input.msg
// DO NOT EDIT!


#ifndef RACE_MESSAGE_PID_INPUT_H
#define RACE_MESSAGE_PID_INPUT_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace race
{
template <class ContainerAllocator>
struct pid_input_
{
  typedef pid_input_<ContainerAllocator> Type;

  pid_input_()
    : pid_vel(0.0)
    , pid_error(0.0)  {
    }
  pid_input_(const ContainerAllocator& _alloc)
    : pid_vel(0.0)
    , pid_error(0.0)  {
  (void)_alloc;
    }



   typedef float _pid_vel_type;
  _pid_vel_type pid_vel;

   typedef float _pid_error_type;
  _pid_error_type pid_error;





  typedef boost::shared_ptr< ::race::pid_input_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::race::pid_input_<ContainerAllocator> const> ConstPtr;

}; // struct pid_input_

typedef ::race::pid_input_<std::allocator<void> > pid_input;

typedef boost::shared_ptr< ::race::pid_input > pid_inputPtr;
typedef boost::shared_ptr< ::race::pid_input const> pid_inputConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::race::pid_input_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::race::pid_input_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace race

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'race': ['/home/nvidia/Desktop/f110_ws/src/simulator/f1_10_sim/race/msg'], 'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::race::pid_input_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::race::pid_input_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::race::pid_input_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::race::pid_input_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::race::pid_input_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::race::pid_input_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::race::pid_input_<ContainerAllocator> >
{
  static const char* value()
  {
    return "15d51ace2dba29e1b19e1332c9d46c17";
  }

  static const char* value(const ::race::pid_input_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x15d51ace2dba29e1ULL;
  static const uint64_t static_value2 = 0xb19e1332c9d46c17ULL;
};

template<class ContainerAllocator>
struct DataType< ::race::pid_input_<ContainerAllocator> >
{
  static const char* value()
  {
    return "race/pid_input";
  }

  static const char* value(const ::race::pid_input_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::race::pid_input_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 pid_vel\n\
float32 pid_error\n\
";
  }

  static const char* value(const ::race::pid_input_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::race::pid_input_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.pid_vel);
      stream.next(m.pid_error);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct pid_input_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::race::pid_input_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::race::pid_input_<ContainerAllocator>& v)
  {
    s << indent << "pid_vel: ";
    Printer<float>::stream(s, indent + "  ", v.pid_vel);
    s << indent << "pid_error: ";
    Printer<float>::stream(s, indent + "  ", v.pid_error);
  }
};

} // namespace message_operations
} // namespace ros

#endif // RACE_MESSAGE_PID_INPUT_H
