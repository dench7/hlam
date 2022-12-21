#!/bin/bash

sudo apt install nvidia-cuda-toolkit

wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb

sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb

wget https://github.com/damomine/aleominer/releases/download/v1.4.0/damominer_v1.4.0.tar

tar -xvf damominer_v1.4.0.tar

chmod +x damominer run_gpu.sh

apt install nano

nano run_gpu.sh
