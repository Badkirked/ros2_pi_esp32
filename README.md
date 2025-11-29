<p align="center">
  <h1 align="center">ROS2 Pi ESP32</h1>
  <p align="center">
    <strong>ROS2 Micro-ROS Setup for Raspberry Pi and ESP32</strong>
  </p>
  <p align="center">
    ROS2 | Micro-ROS | ESP32 | Raspberry Pi | Docker
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/ROS2-Humble-blue?logo=ros&logoColor=white" alt="ROS2">
  <img src="https://img.shields.io/badge/ESP32-Microcontroller-green?logo=espressif&logoColor=white" alt="ESP32">
  <img src="https://img.shields.io/badge/Docker-Container-blue?logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/License-Private-gray" alt="License">
</p>

---

## Overview

ROS2 and Micro-ROS setup scripts for Raspberry Pi and ESP32 development. Includes Docker configuration and installation scripts for Espressif toolchain and Micro-ROS.

---

## Key Features

### ROS2 Setup
- ROS2 Humble installation
- Docker containerization
- Raspberry Pi support
- Development environment

### Micro-ROS
- ESP32 Micro-ROS setup
- Espressif toolchain installation
- Cross-compilation support
- ROS2 integration

---

## Quick Start

### Prerequisites
- Raspberry Pi (or compatible Linux)
- Docker (optional)
- ESP32 development board

### Installation
```bash
git clone https://github.com/badkirked/ros2_pi_esp32.git
cd ros2_pi_esp32
```

### Docker Setup
```bash
docker build -t ros2-esp32 .
```

### Manual Setup
```bash
# Install Espressif toolchain
bash install_espressif.sh

# Install Micro-ROS for ESP32
bash install_microros_esp32.sh
```

---

## Project Structure

```
ros2_pi_esp32/
├── Dockerfile              # Docker configuration
├── install_espressif.sh    # Espressif toolchain installer
└── install_microros_esp32.sh # Micro-ROS ESP32 installer
```

---

## Features

- ROS2 Humble installation
- Micro-ROS ESP32 support
- Docker containerization
- Cross-compilation tools
- Development environment

---

## License

Private repository - All rights reserved.

---

## Author

**badkirked**

- GitHub: [@badkirked](https://github.com/badkirked)

---

<p align="center">
  <sub>Built for ROS2 development</sub>
</p>
