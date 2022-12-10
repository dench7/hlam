#!/bin/bash

cd ~/pathfinder

rustup update

git fetch

git checkout v0.4.3

cargo build --release --bin pathfinder

mv ~/pathfinder/target/release/pathfinder /usr/local/bin/

cd py

source .venv/bin/activate

PIP_REQUIRE_VIRTUALENV=true pip install -e .[dev]

pip install --upgrade pip

systemctl restart starknetd
