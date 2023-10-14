#!/bin/bash

# Script to run after installing Debian from the netinstall iso (with or without additional apps).
# This is based on my Ubuntu script and is in heavy development/testing right now.
# Comment out any sections that don't interest you.
# You will need sudo to be installed to make this script work (and to be in the group)

echo "---------------------------------------------------------------"
echo "General purpose Debian installation script - v0.6, October 2023"
echo "---------------------------------------------------------------"

# Standard error mitigation

set -euo pipefail

# Get a new sources.list that will alow installation of everything in this script

wget https://raw.githubusercontent.com/teknostatik/debian/master/sources.list
sudo mv sources.list /etc/apt/

# Update software

sudo apt update
sudo apt -y upgrade

# Install some basic utilities

sudo apt install -y htop git byobu synaptic xautolock shellcheck xinit kitty zathura pcmanfm featherpad firefox-esr irssi mplayer network-manager-gnome nautilus rsync neofetch

# Install and configure i3

wget https://raw.githubusercontent.com/teknostatik/i3_config/main/install_i3.sh
sudo mv install_i3.sh /usr/local/bin/
sudo chmod 755 /usr/local/bin/install_i3.sh
install_i3.sh

# Install everything needed for Tor

sudo apt install -y torbrowser-launcher onionshare

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

sudo apt install -y gimp rhythmbox vlc brasero sound-juicer transmission

# Install Flatpak

sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install snapd
# Most people won't do this, but I think documenting a working installation of this is important

sudo apt install -y snapd
sudo snap install core
sudo ln -s /var/lib/snapd/snap /snap

# Install some snaps

sudo snap install tube-converter


# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Download and install Dropbox

sudo apt install -y nautilus-dropbox
dropbox start -i

echo "The script has now finished running.
