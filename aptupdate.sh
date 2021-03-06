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

cd testnet
docker compose down

rm -rf ~/testnet/docker-compose.yaml
rm -rf ~/testnet/public_full_node.yaml
rm -rf ~/testnet/genesis.blob
rm -rf ~/testnet/waypoint.txt
docker volume rm /opt/aptos/data_db -f
docker volume rm /testnet/data_db -f

sleep 3
wget https://devnet.aptoslabs.com/genesis.blob
wget https://devnet.aptoslabs.com/waypoint.txt
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/public_full_node/docker-compose.yaml
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/public_full_node/public_full_node.yaml
docker pull docker.io/aptoslabs/validator:devnet_49f08c7419b442461e47164848305fe74e846607

sleep 2

docker run -it aptoslabs/tools:devnet /bin/bash
docker-compose up
