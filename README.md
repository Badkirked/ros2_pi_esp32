# ros2-pi-esp32
//How to Install Docker on Raspberry Pi 5 and Set Up a ROS2 Project with micro-ROS


//Step 1: Install Docker on Raspberry Pi 5

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

sudo systemctl enable docker

//Verify that Docker is running:

sudo systemctl status docker

//You should see an output indicating that Docker is active and running.

//Test Docker Installation

sudo docker run hello-world


//Step 2: Create the Project Directory

//Create and navigate to the project directory: or copy the one from the repo

mkdir ~/ros2_project
cd ~/ros2_project

//Step 3: Create the Dockerfile 

//Create Dockerfile:

//nano Dockerfile ( repo )

// Step 4: Create Installation Scripts

// Create the scripts directory  inside ros2_project

mkdir scripts

cd scripts

// Create install_ros2.sh: ( from repo ) 

//Create install_espressif.sh: ( from repo )

//Create install_microros_esp32.sh: ( from repo)

// Create install_microros_esp32.sh ( from repo )

// Make scripts executable:

cd ros2_project

chmod +x scripts/*.sh

// Step 5: Build the Docker Image

// Build Docker image:

docker build . -t ros2rover:humble-pi5-esp32-v1

// Step 6: Run the ROS2 Docker Container

// Run the container 

docker run -it --name=ros2_humble --net=host --privileged -v /dev:/dev ros2rover:humble-pi5-esp32-v1 bash

// Step 7: Build and Flash the micro-ROS Example

// Navigate to example directory:

cd micro_ros_espidf_component/examples/int32_publisher

// Set Up ESP32 Environment
// Navigate to the example directory:

cd micro_ros_espidf_component/examples/int32_publisher

// Set up the ESP-IDF environment:


. $IDF_PATH/export.sh

// Set the target to ESP32:


idf.py set-target esp32

// Configure the project:


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

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
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


