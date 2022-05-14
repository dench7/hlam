#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install cargo
sudo apt install ca-certificates curl gnupg lsb-release wget jq sed -y

curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/install_rust.sh | bash

curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/install_docker.sh | bash


git clone https://github.com/aptos-labs/aptos-core.git


source $HOME/.cargo/env

cargo install --git https://github.com/aptos-labs/aptos-core.git aptos --tag aptos-cli-latest

which aptos

export WORKSPACE=testnet
mkdir ~/$WORKSPACE
cd ~/$WORKSPACE

wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/fullnode.yaml

aptos genesis generate-keys --output-dir ~/$WORKSPACE

read NODENAME
echo 'export NODENAME='${NODENAME} >> $HOME/.bash_profile
source ~/.bash_profile


export IPADRESS=${wget -qO- eth0.me} >> $HOME/.bash_profil
source ~/.bash_profile

aptos genesis set-validator-configuration \
    --keys-dir ~/$WORKSPACE --local-repository-dir ~/$WORKSPACE \
    --username $NODENAME \
    --validator-host $IPADRESS:6180 \
    --full-node-host $IPADRESS:6182

apt install unzip
wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.1.0/framework.zip
unzip framework.zip

cat <<EOF
root_key: "0x5243ca72b0766d9e9cbf2debf6153443b01a1e0e6d086c7ea206eaf6f8043956"
users:
  - $NODENAME
chain_id: 23
EOF  >> layout.yaml

aptos genesis generate-genesis --local-repository-dir ~/$WORKSPACE --output-dir ~/$WORKSPACE

docker-compose up
