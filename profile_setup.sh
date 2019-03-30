#!/bin/bash

sudo apt update

# install basic editor packages
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

sudo apt-get install vim-gui-common
sudo apt-get install vim-runtime

source install_opencv.sh