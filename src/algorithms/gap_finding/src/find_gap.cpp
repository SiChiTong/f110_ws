/*
 * Copyright (C) 2018, Houssam Abbas, houssamyma@gmail.com
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *   * Neither the names of Stanford University or Willow Garage, Inc. nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

// %Tag(FULLTEXT)%
#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "gap_finding/Gap.h"
#include "gap_finding/gaps.h"
#include "std_msgs/String.h"
#include "std_msgs/Float32.h"
#include "std_msgs/Float64.h"
#include "geometry_msgs/Vector3.h"

#include <string>
#include <vector>


//Every call to the callback must publish the computed average, so the publisher must be globally visible
//(alternately, use the callback-as-class-method way of doing this).
ros::Publisher PUB;

// %Tag(CALLBACK)%

void gapComputingCallback(const sensor_msgs::LaserScan::ConstPtr& msg)
{
  std::vector<float> ranges 	= msg->ranges;
  double angle_increment 	= msg->angle_increment;
  double angle_min 		= msg->angle_min;
  int nranges 			= ranges.size();
  // A gap is a sequence of consecutive ranges that all exceed a certain threshold.
  // Two parameters affect gap finding: the nb of consecutive ranges, and the threshold.
  int nConsRanges 	= 20; //calculate_nb_consecutive_ranges(ranges);
  double threshold 	= 3; //calculate_threshold(ranges);


  int counter = 0;
  double leftAngle  = -1;
  double rightAngle = -1;
  double leftRange  = -1;
  double rightRange = -1;
  gap_finding::gaps mygaps;
  bool gapInProgress = false;
  int j = 0;
  for (int i=1; i< nranges; i++) { // start from 1
	if (ranges[i] >= threshold) {
		counter++;
		if (ranges[i-1] < threshold) { // beginning of potential gap
			leftRange = ranges[i];
			leftAngle = angle_min + (i-1)*angle_increment;
		}
		else if (counter < nConsRanges) { //adding, but no gap yet
		} 
		else { // in gap (new or existing)
			gapInProgress = true;
		}
	} 
	else {
		counter = 0;
		// conclude any gap in progress
		if (gapInProgress) {
			rightRange = ranges[i-1];
			rightAngle = angle_min + (i-2)*angle_increment;
			gap_finding::Gap thisgap;
			thisgap.leftAngle  = leftAngle;
			thisgap.rightAngle = rightAngle;
			thisgap.leftRange  = leftRange;
			thisgap.rightRange = rightRange;
			j++;
			mygaps.gaps.push_back(thisgap);
		}
		gapInProgress = false;
	}
  }
 
  if (j>0) {
  	ROS_INFO("I found %d gaps, last of which is (%.3f, %.3f, %.3f, %.3f)", j, leftAngle, leftRange, rightAngle, rightRange);
  }
  PUB.publish(mygaps);
}

// %EndTag(CALLBACK)%

int main(int argc, char **argv)
{
  /**
   * The ros::init() function needs to see argc and argv so that it can perform
   * any ROS arguments and name remapping that were provided at the command line.
   * The third argument to init() is the name of the node.
   *
   * You must call one of the versions of ros::init() before using any other
   * part of the ROS system.
   */
  ros::init(argc, argv, "find_gap");

  /**
   * NodeHandle is the main access point to communications with the ROS system.
   * The first NodeHandle constructed will fully initialize this node, and the last
   * NodeHandle destructed will close down the node.
   */
  ros::NodeHandle n;

  /**
   * The subscribe() call is how you tell ROS that you want to receive messages
   * on a given topic.  This invokes a call to the ROS
   * master node.  Messages are passed to a callback function, here
   * called chatterCallback.  subscribe() returns a Subscriber object that you
   * must hold on to until you want to unsubscribe. 
   *
   * The second parameter to the subscribe() function is the size of the message
   * queue.  If messages are arriving faster than they are being processed, this
   * is the number of messages that will be buffered up before beginning to throw
   * away the oldest ones.
   */
// %Tag(SUBSCRIBER)%
  ros::Subscriber sub = n.subscribe("/scan", 100, gapComputingCallback);
// %EndTag(SUBSCRIBER)%
  PUB = n.advertise<gap_finding::gaps>("lidar_gap", 1000);

  
  /**
   * ros::spin() will enter a loop, pumping callbacks.  ros::spin()
   * will exit when Ctrl-C is pressed, or the node is shutdown by the master.
   */
// %Tag(SPIN)%
  ros::spin();
// %EndTag(SPIN)%

  return 0;
}
// %EndTag(FULLTEXT)%

