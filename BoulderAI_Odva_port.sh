#!/bin/bash
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted
sudo apt-get update
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-get update
sudo apt-get install ros-kinetic-ros-base -y
sudo apt-get install python-rosdep -y
sudo c_rehash /etc/ssl/certs
sudo rosdep init
rosdep update
grep -q -F 'source /opt/ros/kinetic/setup.bash' ~/.bashrc || echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall -y
source /opt/ros/kinetic/setup.bash
#setup ROS environment variables
grep -q -F ' ROS_MASTER_URI' ~/.bashrc ||  echo 'export ROS_MASTER_URI=http://localhost:11311' | tee -a ~/.bashrc
grep -q -F ' ROS_IP' ~/.bashrc ||  echo "export ROS_IP=$(hostname -I)" | tee -a ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash
cmake .
make
sudo make install 