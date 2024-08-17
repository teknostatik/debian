#!/bin/bash

# Script to run after installing Debian from the netinstall iso
# All command-line stuff designed for headless servers
# Comment out any sections that don't interest you
# You will need sudo to be installed to make this script work (and to be in the group)

echo "----------------------------------------"
echo "Command Line Debian installation script "
echo "----------------------------------------"

# Standard error mitigation

set -euo pipefail

# Add repositories

sudo apt install -y software-properties-common
sudo add-apt-repository contrib non-free

# Update software

sudo apt update
sudo apt -y upgrade

# Install some basic utilities

sudo apt install -y htop git byobu shellcheck rsync curl build-essential avahi-daemon

# Download and install a custom update script

wget https://raw.githubusercontent.com/teknostatik/updateall/master/updateall
sudo mv updateall /usr/local/bin/
sudo chmod 755 /usr/local/bin/updateall

# Install some packages to make remote shells more interesting and then add them to the profile for the logged in user

wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.8.7/fastfetch-linux-amd64.deb
sudo dpkg -i fastfetch-linux-amd64.deb
sudo apt install -y fortune-mod cowsay
echo "echo; fortune | cowsay;echo" >> .profile
echo "echo; fastfetch;echo" >> .profile

# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Set up git

git config --global user.name "Andy Ferguson"
git config --global user.email "andy@teknostatik.org"

# Install Zerotier

curl -s https://install.zerotier.com | sudo bash

# Download unixbench

sudo apt install -y libx11-dev libgl1-mesa-dev libxext-dev perl perl-modules make git
git clone https://github.com/kdlucas/byte-unixbench.git
# uncomment tne next 2 lines to run the benchmark now
# cd byte-unixbench/UnixBench/
# ./Run

echo "The script has now finished running."
