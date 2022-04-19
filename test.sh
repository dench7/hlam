#!/bin/bash

while true
do

echo "============================================================"
echo -e "\033[0;35m"
echo "  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
echo "  11      11   111111     111111   11111111     1111111    ";
echo "  111     11 11      11 11      11 11      11 11       11  ";
echo "  1111    11 11      11 11      11 11      11 11       11  ";
echo "  11 11   11 11      11 11      11 11      11 11           ";
echo "  11  11  11 11      11 11      11 11111111     1111111    ";
echo "  11   11 11 11      11 11      11 11      11          11  ";
echo "  11    1111 11      11 11      11 11      11 11       11  ";
echo "  11     111 11      11 11      11 11      11 11       11  ";
echo "  11      11   111111     111111   11111111     1111111    ";
echo "  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
echo -e "\e[0m"
echo "============================================================"
sleep 2

# Menu

PS3='Select an action: '
options=(
"Python,Rust,Go,Docker,Nvm,Yarn,Npm"
"Aptos"
"Subspace"
"Bashtop"
"LokaBot"
"Exit")
select opt in "${options[@]}"
do
case $opt in

# install

"Python,Rust,Go,Docker,Nvm,Yarn,Npm")

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install Python======================"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 3

sudo apt install python3-pip -y
sudo apt install pipenv -y

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install Rust========================"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep3

sudo apt update
sudo apt install curl make clang pkg-config libssl-dev build-essential git mc jq unzip wget -y
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "======================Install Go========================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep3

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
sleep 1

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "====================Install Docker======================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep3

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
echo "=================Install Nvm,Yarn,Npm========-==========="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 3

curl https://deb.nodesource.com/setup_17.x | sudo bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install nodejs=17.* yarn build-essential jq git -y

break
;;

"Aptos")

PS3='Select an action: '
options=(
"Запустить Aptos"
"Поменять seed"
"Статус синхронизации"
"Логи"
"Посмотреть данные"
"Exit")
select opt in "${options[@]}"
do
case $opt in

# install

"Запустить Aptos")
echo "============================================================"
echo "Installing"
echo "============================================================"
wget -q -O install.sh https://raw.githubusercontent.com/dench7/hlam/main/install.sh && chmod +x install.sh && sudo /bin/bash install.sh

break
;;

"Поменять seed")

wget -q -O seeds.sh https://raw.githubusercontent.com/dench7/hlam/main/seeds.sh && chmod +x seeds.sh && sudo /bin/bash seeds.sh
break
;;

"Статус синхронизации")

curl 127.0.0.1:9101/metrics 2> /dev/null | grep aptos_state_sync_version | grep type
break
;;

"Логи")
docker logs -f aptos-fullnode-1 --tail 500
break
;;

"Посмотреть данные")
wget -q -O idenity.sh https://raw.githubusercontent.com/dench7/hlam/main/idenity.sh && chmod +x idenity.sh && sudo /bin/bash idenity.sh
break
;;

"Exit")
exit
;;
*) echo "invalid option $REPLY";;
esac
done
done

break
;;

"Subspace")

PS3='Select an action: '
options=(
"Prepare server for install"
"Install and run Node"
"Log Node"
"Log Farmer"
"Exit")
select opt in "${options[@]}"
do
case $opt in

"Prepare server for install")
echo "============================================================"
echo "Preparations have begun"
echo "============================================================"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install wget -y
break
;;

"Install and run Node")
echo "============================================================"
echo "Write the name of your node"
echo "============================================================"
read NODENAME
echo 'export NODENAME='${NODENAME} >> $HOME/.bash_profile
echo "============================================================"
echo "Enter your wallet address"
echo "============================================================"
read WALLETADDRESS
echo 'export WALLETADDRESS='${WALLETADDRESS} >> $HOME/.bash_profile
source ~/.bash_profile

mkdir $HOME/subspace; \
cd $HOME/subspace && \
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-farmer-ubuntu-x86_64-snapshot-2022-mar-09 -O farmer && \
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-node-ubuntu-x86_64-snapshot-2022-mar-09 -O subspace && \
sudo chmod +x * && \
sudo mv * /usr/local/bin/ && \
cd $HOME && \
rm -Rvf $HOME/subspace

sudo tee <<EOF >/dev/null /etc/systemd/system/subspace.service
[Unit]
Description=subspace
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=$(which subspace) \
  --chain testnet \
  --wasm-execution compiled \
  --execution wasm \
  --bootnodes "/dns/farm-rpc.subspace.network/tcp/30333/p2p/12D3KooWPjMZuSYj35ehced2MTJFf95upwpHKgKUrFRfHwohzJXr" \
  --rpc-cors all \
  --rpc-methods unsafe \
  --ws-external \
  --validator \
  --telemetry-url "wss://telemetry.polkadot.io/submit/ 1" \
  --name $NODENAME
Restart=on-failure
RestartSec=3
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo tee <<EOF >/dev/null /etc/systemd/system/subspacefarm.service
[Unit]
Description=subspacefarm
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=$(which farmer) \
farm --reward-address $WALLETADDRESS
Restart=on-failure
RestartSec=3
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspace
sudo systemctl enable subspacefarm
sudo systemctl restart subspacefarm
sudo systemctl restart subspace

break
;;

"Log Node")
sudo journalctl -n 100 -f -u subspace
break
;;

"Log Farmer")
sudo journalctl -n 100 -f -u subspacefarm
break
;;


"Exit")
exit
;;
*) echo "invalid option $REPLY";;
esac
done
done

break
;;

"Bashtop")

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install Bashtop====================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

sleep3

sudo apt update
sudo apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update 
sudo apt install bashtop

break
;;

"LokaBot")

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "=====================Install LokaBot====================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
sleep 5

git clone https://github.com/hldh214/lok_bot.git
cd lok_bot
docker buildx build -t lok_bot_local --build-arg PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple .

echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo "==================Run Docker With Token=================="
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

break
;;

"Exit")
exit
;;
*) echo "invalid option $REPLY";;
esac
done
done
