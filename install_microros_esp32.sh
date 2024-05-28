#!/bin/bash
./install_espressif.sh
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_espidf_component.git
export IDF_PATH=$HOME/esp/esp-idf
source $IDF_PATH/export.sh && pip3 install catkin_pkg lark-parser colcon-common-extensions
