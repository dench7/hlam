#!/bin/bash

cd $HOME/sui
sudo docker compose down

IMAGE="mysten/sui-node:2698314d139a3018c2333ddaa670a7cb70beceee"
sed -i.bak "s|image:.*|image: $IMAGE|" $HOME/sui/docker-compose.yaml

docker-compose up -d

