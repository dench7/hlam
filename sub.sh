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


sleep 2

PS3='Select an action: '
options=(
"Установить"
"Логи1"
"Логи2"
"Подписанные блоки"
"Перезапуск фермера и ноды"
"Exit")
select opt in "${options[@]}"
do
case $opt in


"Установить")

echo "============================================================"
echo "Installing"
echo "============================================================"

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install wget -y
sudo apt install htop

mkdir $HOME/subspace
cd $HOME/subspace
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-farmer-ubuntu-x86_64-snapshot-2022-mar-09 -O farmer
wget https://github.com/subspace/subspace/releases/download/snapshot-2022-mar-09/subspace-node-ubuntu-x86_64-snapshot-2022-mar-09 -O subspace
sudo chmod +x *
sudo mv * /usr/local/bin/
cd $HOME
rm -Rvf $HOME/subspace

echo "============================================================"
echo "Setup NodeName:"
echo "============================================================"
read NODENAME
echo 'export NODENAME='${NODENAME} >> $HOME/.bash_profile
source ~/.bash_profile

echo "============================================================"
echo "SUBSPACE_ADDRESS:"
echo "============================================================"
read SUBSPACE_ADDRESS
echo 'export SUBSPACE_ADDRESS='${SUBSPACE_ADDRESS} >> $HOME/.bash_profile
source ~/.bash_profile

echo "============================================================"
echo "create service"
echo "============================================================"

echo -e '\n\e[45mRunning\e[0m\n' && sleep 1
echo -e '\n\e[45mCreating a service\e[0m\n' && sleep 1
echo "[Unit]
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
" > $HOME/subspaced.service
sudo mv $HOME/subspaced.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/
Storage=persistent
EOF

sudo systemctl daemon-reload
sudo systemctl enable subspaced
sudo systemctl restart subspaced

sleep 5

echo "============================================================"
echo "create farmerd service"
echo "============================================================"

echo -e '\n\e[45mRunning\e[0m\n' && sleep 1
echo -e '\n\e[45mCreating a service\e[0m\n' && sleep 1
echo "[Unit]
Description=Subspace Farmer
After=network.target
Service]
Type=simple
User=$USER
ExecStart=$(which farmer) farm --reward-address=$SUBSPACE_ADDRESS
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
" > $HOME/farmerd.service
sudo mv $HOME/farmerd.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/
Storage=persistent
EOF

break
;;
"Логи1")
sudo journalctl -u subspaced -f -o cat
break
;;
"Логи2")
sudo journalctl -u farmerd -f -o cat
break
;;
"Подписанные блоки")
sudo journalctl -u farmerd -f -o cat
break
;;
"Перезапуск фермера и ноды")
sudo systemctl restart farmerd subspaced
break
;;
"Exit")
exit
;;
esac
done
done
