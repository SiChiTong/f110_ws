# f110-upenn-course
This is for code and ONLY code - not lectures, planning docs, manuals, write-ups, or anything else (those things go on DB). 
This repo will contain all code we create or re-use from other institutions and which is needed to complete the steps in the Reference Manual. So, e.g., it can contain the wall-following code (we created that) and simulator code (MIT did that), but not the hokuyo node code (it's reliably available on ros.org).
It will also contain solutions to lab assignments. 

We should aim to have a clean, ready-to-use repo, like all open-source projects out there, and there is no getting around being disciplined about it if we want this course to take off and grow.
When in doubt, please ask Houssam (or each other) if some code should go in there. Remember git branch for your experiments. have fun!

In order to add the contents of this repository to your workspace on your local machine, do the following:

Clone this repository into a folder on your computer
```bash
$ cd ~/sandbox (or whatever folder you want to work in)
$ git clone https://github.com/mlab-upenn/f110-upenn-course.git
```

We begin by creating a workspace. You can call your workspace anything, for the purposes of this setup guide we call our workspace f110_ws. In your root folder, execute these commands:
```bash
$ mkdir -p ~/f110_ws/src
```

Copy the contents of this repository into ~/f110_ws/src
```bash
$ cp -r f110-upenn-course f110_ws/src
```

You will need to install these with apt-get in order for the car and Gazebo simulator to work.
```bash
$ sudo apt-get install ros-kinetic-ros-control ros-kinetic-ros-controllers ros-kinetic-gazebo-ros-control ros-kinetic-ackermann-msgs ros-kinetic-joy
```

Make all the Python scripts executable (by default they are set to non-executable when downloaded from Github, or anywhere for that matter)
```bash
find . -name "*.py" -exec chmod +x {} \;
```

Then build:
```bash
$ cd ~/f110_ws
$ catkin_make
```

The generated devel and build folders at the root of the workspace are where the linked libraries and the compiled code in machine language resides. Source the environment using
```bash
$ source devel/setup.bash
```

You can now run a launch file using the following. You should see Gazebo load with the car doing a simple wall follow in a world.
```bash
$ roslaunch wall_following wall_following.launch
```

TROUBLESHOOTING
If for some reason you get a build error, try deleting the CMakeLists.txt file and running catkin_make again. 
