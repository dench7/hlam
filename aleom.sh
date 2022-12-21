#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install wget jq git build-essential pkg-config libssl-dev -y

. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/rust.sh)

sudo apt install nvidia-cuda-toolkit

sudo apt-get install wget

wget https://github.com/damomine/aleominer/releases/download/v2.1.2/damominer_linux_v2.1.2.tar

tar -xvf damominer_linux_v2.1.2.tar

chmod +x damominer

chmod +x run_gpu.sh
