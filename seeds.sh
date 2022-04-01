#!/bin/bash

echo -e "\e[1m\e[32m1. Updating list of dependencies... \e[0m" && sleep 1
sudo apt-get update   &> /dev/null
# Installing yq to modify yaml files
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64  &> /dev/null
sudo chmod a+x /usr/local/bin/yq
cd $HOME/aptos

echo "=================================================="

echo -e "\e[1m\e[32m2. Download list of active seeds... \e[0m" && sleep 1
wget -P $HOME/aptos https://raw.githubusercontent.com/dench7/hlam/main/seeds.yaml  &> /dev/null

echo "=================================================="

echo -e "\e[1m\e[32m3. Updating lists of seeds ... \e[0m" && sleep 1

/usr/local/bin/yq ea -i 'select(fileIndex==0).full_node_networks[0].seeds = select(fileIndex==1).seeds | select(fileIndex==0)' $HOME/aptos/public_full_node.yaml $HOME/aptos/seeds.yaml
rm $HOME/aptos/seeds.yaml
echo "=================================================="

echo -e "\e[1m\e[32m4. Restart aptos node ... \e[0m" && sleep 1

# If node was installed as docker service
sudo docker compose restart &> /dev/null

# If node was installed as systemctl services
sudo systemctl restart aptos-fullnode.service &> /dev/null
