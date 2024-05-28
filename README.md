# ros2-pi-esp32
//How to Install Docker on Raspberry Pi 5 and Set Up a ROS2 Project with micro-ROS


//Step 1: Install Docker on Raspberry Pi 5

//Update your system:

sudo apt-get update

//Install required packages:

sudo apt-get install ca-certificates curl gnupg lsb-release

//Add Docker’s official GPG key:

sudo mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

//Set up the Docker repository:

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

//Install Docker Engine

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

//Add your user to the Docker group:


sudo usermod -aG docker $USER

//reboot or logout 

//Enable Docker to Start at Boot
//If you want Docker to start automatically at boot, enable the Docker service with:


sudo systemctl enable docker

//Enable Docker to start at boot:


//Verify that Docker is running:


sudo systemctl status docker
//You should see an output indicating that Docker is active and running.

//Test Docker Installation
//To ensure Docker is installed correctly and running, run the hello-world container:

sudo docker run hello-world


//Step 2: Create the Project Directory

//Create and navigate to the project directory:

mkdir ~/ros2_project
cd ~/ros2_project

//Step 3: Create the Dockerfile

//Create Dockerfile:

sudo apt-get install nano


nano Dockerfile


# Use the Ubuntu 22.04 (Jammy) base image
FROM ubuntu:jammy

# Set up locale and language settings
RUN locale
RUN apt update && apt install locales -y
RUN locale-gen it_IT it_IT.UTF-8
RUN update-locale LC_ALL=it_IT.UTF-8 LANG=it_IT.UTF-8
ENV LANG=it_IT.UTF-8

# Set environment variables for ROS2 installation
ENV ROS_VERSION=2
ENV ROS_DISTRO=humble
ENV ROS_PYTHON_VERSION=3
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary software properties and curl
RUN apt install software-properties-common -y
RUN add-apt-repository universe
RUN apt update && apt install curl -y

# Add the ROS2 repository and key
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update and upgrade the system packages
RUN apt update && apt upgrade -y

# Set the working directory to /ros2_project
WORKDIR /ros2_project

# Copy the script files to the working directory
COPY scripts/*.sh /ros2_project/

# Make the script files executable
RUN chmod +x ./*.sh

# Run the installation scripts
RUN ./install_ros2.sh
RUN ./install_microros_esp32.sh



// Step 4: Create Installation Scripts

// Create the scripts directory:

mkdir scripts

cd scripts

// Create install_ros2.sh:

nano install_ros2.sh

#!/bin/bash
apt update && apt install -y ros-humble-ros-base ros-dev-tools
echo 'source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash' >> ~/.bashrc


//Create install_espressif.sh:

nano install_espressif

#!/bin/bash
if [ ! -d ~/esp ]; then
    apt-get update -y
    apt-get install -y git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
    mkdir -p ~/esp
    cd ~/esp
    git clone -b v5.2 --recursive https://github.com/espressif/esp-idf.git
    cd ~/esp/esp-idf
    ./install.sh esp32
    export IDF_PATH=$HOME/esp/esp-idf
    echo export IDF_PATH=$HOME/esp/esp-idf >> /root/.bashrc
    . $IDF_PATH/export.sh
else
    echo "'esp' folder already exists."
fi


//Create install_microros_esp32.sh:

nano install_microros_esp32.sh

#!/bin/bash

# Ensure the script is run from the correct directory
SCRIPT_DIR=$(dirname "$0")

# Run the install_espressif.sh script
$SCRIPT_DIR/install_espressif.sh

# Clone the micro-ROS component
if [ ! -d "$HOME/micro_ros_espidf_component" ]; then
    git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_espidf_component.git $HOME/micro_ros_espidf_component
else
    echo "micro_ros_espidf_component already exists."
fi

# Set up the ESP-IDF environment
export IDF_PATH=$HOME/esp/esp-idf
source $IDF_PATH/export.sh && pip3 install catkin_pkg lark-parser colcon-common-extensions



// Make scripts executable:

cd ros2_project

chmod +x scripts/*.sh

// Step 5: Build the Docker Image

// Build Docker image:

docker build . -t ros2rover:humble-pi5-esp32-v1


xxxxx

//Step 6: Run the ROS2 Docker Container

// Run the container :

//docker stop ros2_humble
//docker rm ros2_humble
docker run -it --name=ros2_humble --net=host --privileged -v /dev:/dev ros2rover:humble-pi5-esp32-v1 bash



Step 7: Build and Flash the micro-ROS Example

// Navigate to example directory:

cd micro_ros_espidf_component/examples/int32_publisher


xxxxxxxxxxxxxxxx

Set Up ESP32 Environment
Navigate to the example directory:


cd micro_ros_espidf_component/examples/int32_publisher
Set up the ESP-IDF environment:


. $IDF_PATH/export.sh
// Set the target to ESP32:


idf.py set-target esp32
Configure the project:


idf.py menuconfig
//In the menuconfig, set the micro-ROS Agent IP and WiFi configuration, then save and exit.
//Build the project:


idf.py build
// Ensure permissions for the USB port:


sudo chmod 666 /dev/ttyUSB0  # Replace ttyUSB0 with your actual device name
//Flash the firmware to the ESP32:


idf.py flash -p /dev/ttyUSB0
//Create and Run the micro-ROS Agent
//Open a new terminal and run the micro-ROS agent:


docker run -it --rm --net=host microros/micro-ros-agent:humble udp4 --port 8888 -v6
//Interact with ROS2 Topics
//In the ROS2 Humble container, source the ROS2 setup script:


source /opt/ros/humble/setup.bash
//List the available topics:


ros2 topic list
// Echo the messages from the /freertos_int32_publisher topic:


ros2 topic echo /freertos_int32_publisher
// Summary of Commands


# Navigate to the example directory
cd micro_ros_espidf_component/examples/int32_publisher

# Set up the ESP-IDF environment
. $IDF_PATH/export.sh

# Set the target to ESP32
idf.py set-target esp32

# Configure the project (set micro-ROS Agent IP and WiFi configuration)
idf.py menuconfig

# Build the project
idf.py build

# Ensure permissions for the USB port
sudo chmod 666 /dev/ttyUSB0  # Replace ttyUSB0 with your actual device name

# Flash the firmware to the ESP32
idf.py flash -p /dev/ttyUSB0

# Open a new terminal and run the micro-ROS agent
docker run -it --rm --net=host microros/micro-ros-agent:humble udp4 --port 8888 -v6

# In the ROS2 Humble container, source the ROS2 setup script
source /opt/ros/humble/setup.bash

# List the available topics
ros2 topic list

# Echo the messages from the /freertos_int32_publisher topic
ros2 topic echo /freertos_int32_publisher
By following these steps, you will be able to build and flash the micro-ROS example on your ESP32, run the micro-ROS agent, and interact with ROS2 topics from your Raspberry Pi 5.




xxxxxxxx





// Set up ESP32 environment:

. \$IDF_PATH/export.sh
idf.py set-target esp32
idf.py menuconfig
idf.py build
sudo chmod 666 /dev/ttyUSB0
idf.py flash -p /dev/ttyUSB0

// Step 8: Create and Run the micro-ROS Agent

// Run the micro-ROS agent:

docker run -it --rm --net=host microros/micro-ros-agent:humble udp4 --port 8888 -v6

// Step 9: Interact with ROS2 Topics

// Source ROS2 setup script:

source /opt/ros/humble/setup.bash

// List and echo topics:

ros2 topic list
ros2 topic echo /freertos_int32_publisher


