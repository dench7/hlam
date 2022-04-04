#!/bin/bash

while true
do

echo "=============================================================="
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
echo "==============================================================="

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install wget -y

mkdir $HOME/subspace; \
cd $HOME/subspace && \
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-farmer-ubuntu-x86_64-snapshot-2022-mar-09 -O farmer && \
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-node-ubuntu-x86_64-snapshot-2022-mar-09 -O subspace && \
sudo chmod +x * && \
sudo mv * /usr/local/bin/ && \
cd $HOME && \
rm -Rvf $HOME/subspace

echo "============================================================"
echo "Create Wallet"
echo "============================================================"

NAME_NODE="[NODERS]"
                echo "============================================================"
                echo "Set parameters"
                echo "============================================================"
                echo "Enter NodName:"
                echo "============================================================"
                
read NICKNAME
NICKNAME=$NICKNAME$NAME_NODE
echo "export NICKNAME="${NICKNAME} >> $HOME/.bash_profile

                echo "============================================================"
                echo "Enter SUBSPACE_ADDRESS"
                echo "============================================================"
               
read SUBSPACE_ADDRESS
echo "export SUBSPACE_ADDRESS="${SUBSPACE_ADDRESS=} >> $HOME/.bash_profile
source $HOME/.bash_profile

                echo "============================================================"
                echo "Create Servis"
                echo "============================================================"

sudo tee <<EOF >/dev/null /etc/systemd/system/subspaced.service
[Unit]
Description=Subspace Node
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which subspace) \\
--chain testnet \\
--wasm-execution compiled \\
--execution wasm \\
--bootnodes "/dns/farm-rpc.subspace.network/tcp/30333/p2p/12D3KooWPjMZuSYj35ehced2MTJFf95upwpHKgKUrFRfHwohzJXr" \\
--rpc-cors all \\
--rpc-methods unsafe \\
--ws-external \\
--validator \\
--telemetry-url "wss://telemetry.polkadot.io/submit/ 1" \\
--name $NICKNAME
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload && \
sudo systemctl enable subspaced && \
sudo systemctl restart subspaced

sleep 5
                echo "============================================================"
                echo "Create Farmer"
                echo "============================================================"

sudo tee <<EOF >/dev/null /etc/systemd/system/farmerd.service
[Unit]
Description=Subspace Farmer
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which farmer) farm --reward-address=$SUBSPACE_ADDRESS
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload && \
sudo systemctl enable farmerd && \
sudo systemctl restart farmerd
