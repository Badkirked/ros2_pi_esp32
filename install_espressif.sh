#!/bin/bash
if [ ! -d ~/esp ]; then
    apt-get update -y
    apt-get install git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 -y
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
