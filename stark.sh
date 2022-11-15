#!/bin/bash

cd ~/pathfinder

rustup update

git fetch

git checkout vv0.4.0

cargo build --release --bin pathfinder

mv ~/pathfinder/target/release/pathfinder /usr/local/bin/

cd py

source .venv/bin/activate

PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt

pip install --upgrade pip

systemctl restart starknetd
