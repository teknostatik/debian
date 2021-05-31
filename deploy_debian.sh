#!/bin/bash

# Script to run after installing Debian from the netinstall iso (with or without additional apps).
# This is based on my Ubuntu script and is in heavy development/testing right now.
# Comment out any sections that don't interest you.
# You will need sudo to be installed to make this script work (and to be in the group)

echo "-----------------------------------------------------------"
echo "General purpose Debian installation script - v0.1, May 2021"
echo "-----------------------------------------------------------"

# Standard error mitigation

set -euo pipefail

# Update software

sudo apt update
sudo apt -y upgrade

# Install the i3 window manager and some basic utilities

sudo apt install -y i3 i3blocks feh arandr git curl byobu synaptic lightdm xautolock shellcheck xinit kitty zathura pcmanfm featherpad firefox-esr

# Install everything needed for ProtonVPN and Tor
# See https://protonvpn.com/support/linux-vpn-tool/ for how to install

sudo apt install -y openvpn dialog python3-pip python3-setuptools torbrowser-launcher onionshare
sudo pip3 install protonvpn-cli
sudo protonvpn init

# Download and install a custom update script

wget https://raw.githubusercontent.com/teknostatik/updateall/master/updateall
sudo mv updateall /usr/local/bin/
sudo chmod 755 /usr/local/bin/updateall

# Install some packages to make remote shells more interesting and then add them to the profile for the logged in user

sudo apt install -y neofetch fortune-mod cowsay
echo "echo; fortune | cowsay;echo" >> .profile
echo "echo; neofetch;echo" >> .profile

# Install the applications I use for writing, editing and previewing text

sudo apt install -y pandoc texlive texlive-latex-extra abiword

# Install some desktop applications for creating, editing and playing common media types

sudo apt install -y gimp youtube-dl rhythmbox vlc brasero sound-juicer transmission

## Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias mp='multipass list'" >> .bashrc
echo "alias top='bpytop'" >> .bashrc

# Download and install Dropbox

sudo apt install -y nautilus-dropbox
dropbox start -i

# Set up i3. Comment this out if you want to use your own config file or build your config from scratch.

wget https://raw.githubusercontent.com/teknostatik/i3_config/main/config
mkdir .config
mkdir .config/i3/
mv config ~/.config/i3/config

# Set up i3 wallpaper

sudo mkdir /usr/share/wallpaper
cd /usr/share/wallpaper
sudo wget https://www.dropbox.com/s/0yg8txbgw0ifqmg/9dy0gvxq7fl61.png
sudo wget https://www.dropbox.com/s/j9mmfedrc8r9zba/231-2311974_big.jpg
sudo wget https://www.dropbox.com/s/cljxhezhxuu3nce/background.png
sudo wget https://www.dropbox.com/s/f2rkmbv13c8t769/1920x1080-dark-linux.png
sudo wget https://www.dropbox.com/s/1i7g8u5h6whd5dv/3430638.png
sudo wget https://www.dropbox.com/s/bkae9ethe3jqbod/jyrji9bnp3171.jpg
cd $HOME
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/randomise_wallpaper
sudo mv randomise_wallpaper /usr/local/bin/
sudo chmod 755 /usr/local/bin/randomise_wallpaper

echo "The script has now finished running."
