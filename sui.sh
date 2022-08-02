#!/bin/bash

systemctl stop suid 

rm -rf /var/sui/db/* /var/sui/genesis.blob $HOME/sui

source $HOME/.cargo/env

cd $HOME

git clone https://github.com/MystenLabs/sui.git

cd sui

git remote add upstream https://github.com/MystenLabs/sui

git fetch upstream

git checkout -B devnet --track upstream/devnet

cargo build --release

mv ~/sui/target/release/sui-node /usr/local/bin/

mv ~/sui/target/release/sui /usr/local/bin/

wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob

systemctl restart suid
