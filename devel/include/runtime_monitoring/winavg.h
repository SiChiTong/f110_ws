// Generated by gencpp from file runtime_monitoring/winavg.msg
// DO NOT EDIT!


#ifndef RUNTIME_MONITORING_MESSAGE_WINAVG_H
#define RUNTIME_MONITORING_MESSAGE_WINAVG_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace runtime_monitoring
{
template <class ContainerAllocator>
struct winavg_
{
  typedef winavg_<ContainerAllocator> Type;

  winavg_()
    : avg(0.0)
    , windowsize(0)  {
    }
  winavg_(const ContainerAllocator& _alloc)
    : avg(0.0)
    , windowsize(0)  {
  (void)_alloc;
    }



   typedef double _avg_type;
  _avg_type avg;

   typedef int32_t _windowsize_type;
  _windowsize_type windowsize;





  typedef boost::shared_ptr< ::runtime_monitoring::winavg_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::runtime_monitoring::winavg_<ContainerAllocator> const> ConstPtr;

}; // struct winavg_

typedef ::runtime_monitoring::winavg_<std::allocator<void> > winavg;

typedef boost::shared_ptr< ::runtime_monitoring::winavg > winavgPtr;
typedef boost::shared_ptr< ::runtime_monitoring::winavg const> winavgConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::runtime_monitoring::winavg_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::runtime_monitoring::winavg_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace runtime_monitoring

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'runtime_monitoring': ['/home/nvidia/Desktop/f110_ws/src/algorithms/runtime_monitoring/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::runtime_monitoring::winavg_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::runtime_monitoring::winavg_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::runtime_monitoring::winavg_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::runtime_monitoring::winavg_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::runtime_monitoring::winavg_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::runtime_monitoring::winavg_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::runtime_monitoring::winavg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ee07ea8681a58f4616a5f3928b9086e8";
  }

  static const char* value(const ::runtime_monitoring::winavg_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xee07ea8681a58f46ULL;
  static const uint64_t static_value2 = 0x16a5f3928b9086e8ULL;
};

template<class ContainerAllocator>
struct DataType< ::runtime_monitoring::winavg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "runtime_monitoring/winavg";
  }

  static const char* value(const ::runtime_monitoring::winavg_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::runtime_monitoring::winavg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 avg\n\
int32 windowsize\n\
";
  }

  static const char* value(const ::runtime_monitoring::winavg_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::runtime_monitoring::winavg_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.avg);
      stream.next(m.windowsize);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct winavg_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::runtime_monitoring::winavg_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::runtime_monitoring::winavg_<ContainerAllocator>& v)
  {
    s << indent << "avg: ";
    Printer<double>::stream(s, indent + "  ", v.avg);
    s << indent << "windowsize: ";
    Printer<int32_t>::stream(s, indent + "  ", v.windowsize);
  }
};

} // namespace message_operations
} // namespace ros

#endif // RUNTIME_MONITORING_MESSAGE_WINAVG_H
