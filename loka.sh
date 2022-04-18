#!/bin/bash

# Logo
echo "==============================================================="
echo -e "\033[0;35m"
echo "                                                               ";
echo "  11      11    111111     111111   11111111      1111111      ";
echo "  111     11  11      11 11      11 11      11  11       11    ";
echo "  1111    11  11      11 11      11 11      11  11       11    ";
echo "  11 11   11  11      11 11      11 11      11  11             ";
echo "  11  11  11  11      11 11      11 11111111      1111111      ";
echo "  11   11 11  11      11 11      11 11      11           11    ";
echo "  11    1111  11      11 11      11 11      11  11       11    ";
echo "  11     111  11      11 11      11 11      11  11       11    ";
echo "  11      11    111111     111111   11111111      1111111      ";
echo "                                                               ";
echo -e "\e[0m"
echo "================================================================"

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=============Updates============="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 3

sudo apt-get update
sudo apt-get install jq -y
sudo yum install tmux

sleep 3
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=============Install Python==========="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

sleep 5
sudo apt install python3-pip -y
sudo apt install pipenv -y

sleep 3
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "============Install Docker============="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 5

. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/docker.sh)


echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=============Install Bot==============="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

sleep 5

git clone https://github.com/hldh214/lok_bot.git
cd lok_bot
docker buildx build -t lok_bot_local --build-arg PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple .
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=======================================Install Successful===================================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
