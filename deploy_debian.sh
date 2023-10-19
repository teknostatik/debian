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

sudo apt install -y htop git byobu synaptic xautolock shellcheck xinit kitty zathura pcmanfm featherpad firefox-esr irssi mplayer network-manager-gnome nautilus rsync neofetch gnome-core curl

# Install the i3 window manager and some basic utilities (all of these are referenced in my i3 config file, so need to be installed)

sudo apt install -y i3 i3blocks feh arandr scrot xautolock barrier kitty imagemagick polybar caffeine

# Set up i3. Comment this out if you want to use your own config file or build your config from scratch.

wget https://raw.githubusercontent.com/teknostatik/i3_config/main/config
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/lock.sh
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/kitty.conf
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/polybar_config
mkdir /home/andy/.config/i3
mv config /home/andy/.config/i3/
sudo mv lock.sh /usr/local/bin/
mkdir /home/andy/.config/kitty
mv kitty.conf /home/andy/.config/kitty/
mkdir /home/andy/.config/polybar
mv polybar_config /home/andy/.config/polybar/config

# Set up i3 wallpaper

sudo mkdir /usr/share/wallpaper

# Copy any existing wallpapers into this new directory (delete any you don't like later)

sudo cp -R /usr/share/backgrounds/* /usr/share/wallpaper

# In my i3 config file we switch wallpaper using MOD + Z, but this requires a script
cd $HOME
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/randomise_wallpaper
sudo mv randomise_wallpaper /usr/local/bin/
sudo chmod 755 /usr/local/bin/randomise_wallpaper

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
# Most people won't do this, but I think documenting a working installation of this is important

sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install vscode

flatpak install flathub com.visualstudio.code -y


# Install snapd
# Most people won't do this, but I think documenting a working installation of this is important

sudo apt install -y snapd
sudo snap install core
sudo ln -s /var/lib/snapd/snap /snap

# Install some snaps

sudo snap install tube-converter
sudo snap install unixbench

# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Set up git

git config --global user.name "Andy Ferguson"
git config --global user.email "teknostatik@protonmail.com"

# install ProtonVPN

wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb
sudo dpkg -i protonvpn-stable-release_1.0.3-2_all.deb
sudo apt update
sudo apt install -y proton-vpn-gnome-desktop

# Install Zerotier

curl -s https://install.zerotier.com | sudo bash

# Download and install Dropbox

sudo apt install -y nautilus-dropbox
dropbox start -i

echo "The script has now finished running.
