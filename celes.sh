#!/bin/bash

echo "=================================================="
echo -e "\033[0;35m"
echo "                                                             ";
echo "  11      11   111111     111111   11111111     1111111      ";
echo "  111     11 11      11 11      11 11      11 11       11    ";
echo "  1111    11 11      11 11      11 11      11 11       11    ";
echo "  11 11   11 11      11 11      11 11      11 11             ";
echo "  11  11  11 11      11 11      11 11111111     1111111      ";
echo "  11   11 11 11      11 11      11 11      11          11    ";
echo "  11    1111 11      11 11      11 11      11 11       11    ";
echo "  11     111 11      11 11      11 11      11 11       11    ";
echo "  11      11   111111     111111   11111111     1111111      ";
echo "                                                             ";
echo -e "\e[0m"
echo "=================================================="


"Prepare the server for installation"
               echo "============================================================"
               echo "Preparation has begun"
               echo "============================================================"
               
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
sudo apt install -y uidmap dbus-user-session
cd $HOME
ver="1.17.2"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

               echo "============================================================"
               echo "The server is ready!"
               echo "============================================================"
            
"Install Celestia Bridge")
                echo "============================================================"
                echo "Installation started"
                echo "============================================================"

cd $HOME
rm -rf celestia-node
git clone https://github.com/celestiaorg/celestia-node.git
cd celestia-node
git checkout v0.2.0
make install

               echo "============================================================"
               echo "Get trusted hash"
               echo "============================================================"

TRUSTED_SERVER=$(curl -s "https://raw.githubusercontent.com/maxzonder/celestia/main/trusted_server.txt")
TRUSTED_SERVER="http://$TRUSTED_SERVER"

               echo "============================================================"
               echo "Init and config bridge"
               echo "===========================================================
               
celestia bridge init --core.remote $TRUSTED_SERVER
sed -i.bak -e 's/PeerExchange = false/PeerExchange = true/g' $HOME/.celestia-bridge/config.toml
BootstrapPeers="[\"/dns4/andromeda.celestia-devops.dev/tcp/2121/p2p/12D3KooWKvPXtV1yaQ6e3BRNUHa5Phh8daBwBi3KkGaSSkUPys6D\", \"/dns4/libra.celestia-devops.dev/tcp/2121/p2p/12D3KooWK5aDotDcLsabBmWDazehQLMsDkRyARm1k7f1zGAXqbt4\", \"/dns4/norma.celestia-devops.dev/tcp/2121/p2p/12D3KooWHYczJDVNfYVkLcNHPTDKCeiVvRhg8Q9JU3bE3m9eEVyY\"]"
sed -i -e "s|BootstrapPeers *=.*|BootstrapPeers = $BootstrapPeers|" $HOME/.celestia-bridge/config.toml

               echo "============================================================"
               echo "Create and run service"
               echo "============================================================"

sudo tee /etc/systemd/system/celestia-bridge.service > /dev/null <<EOF
[Unit]
  Description=celestia-bridge
  After=network-online.target
[Service]
  User=$USER
  ExecStart=$(which celestia) bridge start
  Restart=on-failure
  RestartSec=10
  LimitNOFILE=4096
[Install]
  WantedBy=multi-user.target
EOF

sudo systemctl enable celestia-bridge
sudo systemctl daemon-reload
sudo systemctl restart celestia-bridge

               echo "============================================================"
               echo "Installation complete!"
               echo "============================================================"

"Check node status")
               echo "============================================================"
               echo "Check node status"
               echo "============================================================"

journalctl -u celestia-bridge -o cat -f
