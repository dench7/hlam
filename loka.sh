#!/bin/bash

while true
do

# Logo
echo "==========================================================="
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
echo "============================================================"

sudo apt-get update
sudo apt-get install jq -y

sleep 3

echo "======Install Python======"
sudo apt install python3-pip -y
sudo apt install pipenv -y

sleep 3

echo "======Install Docker======"
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/docker.sh)

sleep 3

echo "=====Install Bot====="

git clone https://github.com/hldh214/lok_bot.git
cd lok_bot
docker buildx build -t lok_bot_local --build-arg PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple .

echo "Бот готов ,укажи айди профиля в команде docker run -e TOKEN=YOUR_X_ACCESS_TOKEN lok_bot_local"

done
