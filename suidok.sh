#!/bin/bash

#Install Linux dependencies.
sudo apt update \
&& apt-get install -y --no-install-recommends \
apt-transport-https \
ca-certificates \
curl \
software-properties-common


#Install Docker.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update \
sudo apt install docker-ce


#Add your user to docker Group.
sudo usermod -aG docker ${USER}


#Install Docker Compose.
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


#Create SUI directory.
mkdir -p $HOME/sui
cd $HOME/sui


#Download fullnode.yaml.
wget -O $HOME/sui/fullnode-template.yaml https://github.com/MystenLabs/sui/raw/main/crates/sui-config/data/fullnode-template.yaml


#Download genesis state file.
wget -O $HOME/sui/genesis.blob  https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob


#Download docker-compose file and update Sui Node image in it:
IMAGE="mysten/sui-node:2d07756360c28e35d7c60816bb0f1ed94ccf356e"
wget -O $HOME/sui/docker-compose.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/docker/fullnode/docker-compose.yaml
sed -i.bak "s|image:.*|image: $IMAGE|" $HOME/sui/docker-compose.yaml


#Start SUI Full Node in the Docker container.
docker-compose up -d
