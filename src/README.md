# f110-upenn-course
This is for code and ONLY code - not lectures, planning docs, manuals, write-ups, or anything else (those things go on DB). 
This repo will contain all code we create or re-use from other institutions and which is needed to complete the steps in the Reference Manual. So, e.g., it can contain the wall-following code (we created that) and simulator code (MIT did that), but not the hokuyo node code (it's reliably available on ros.org).
It will also contain solutions to lab assignments. 

We should aim to have a clean, ready-to-use repo, like all open-source projects out there, and there is no getting around being disciplined about it if we want this course to take off and grow.
When in doubt, please ask Houssam (or each other) if some code should go in there. Remember git branch for your experiments. have fun!

In order to add the contents of this repository to your workspace on your local machine, do the following:

We begin by creating a workspace. In your root folder, execute these commands:
```bash
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/src
```

Copy the contents of this repository into ~/catkin_ws/src
Then build:
```bash
cd ~/catkin_ws
catkin_make
```

The generated devel and build folders at the root of the workspace are where the linked libraries and the compiled code in machine language resides. Source the environment using
```bash
source devel/setup.bash
```

You can now run a launch file using the following:
```bash
roslaunch wall_following wall_following.launch
```
