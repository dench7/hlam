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

echo "xxxxxxxxxxxxxxxxx"
echo "=====Updates====="
echo "xxxxxxxxxxxxxxxxx"
sleep 3

sudo apt-get update
sudo apt-get install jq -y

sleep 3
echo "xxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "======Install Python======"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxx"

sleep 5
sudo apt install python3-pip -y
sudo apt install pipenv -y

sleep 3
echo "xxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "======Install Docker======"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 5

. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/docker.sh)


echo "xxxxxxxxxxxxxxxxxxxxx"
echo "=====Install Bot====="
echo "xxxxxxxxxxxxxxxxxxxxx"

sleep 5

git clone https://github.com/hldh214/lok_bot.git
cd lok_bot
docker buildx build -t lok_bot_local --build-arg PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple .
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "Бот готов ,укажи айди профиля в команде docker run -e TOKEN=YOUR_X_ACCESS_TOKEN lok_bot_local"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
