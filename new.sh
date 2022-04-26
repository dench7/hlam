#!/bin/bash

sudo apt update

sudo apt install htop -y

#установка докера
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install Docker======================"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 5

sudo apt update
sudo apt install wget -y
wget -O get-docker.sh https://get.docker.com
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose
rm -f get-docker.sh
sudo usermod -aG docker $USER

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install Python======================"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

sleep 5
sudo apt install python3-pip -y
sudo apt install pipenv -y

sudo apt update
sudo apt install mc jq curl build-essential git wget -y
sudo rm -rf /usr/local/go
curl https://dl.google.com/go/go1.17.linux-amd64.tar.gz | sudo tar -C /usr/local -zxvf -

cat <<'EOF' >>$HOME/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF

source $HOME/.profile
sleep 3

#установить nvm,yarn,npm 
curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/install_node14.sh | bash

#установить rust
curl -s https://raw.githubusercontent.com/razumv/helpers/main/tools/install_rust.sh | bash
