#!/bin/bash

# Script to run after installing Debian from the netinstall iso (with or without additional apps).
# This is based on my Ubuntu script and is in heavy development/testing right now.
# Comment out any sections that don't interest you.
# You will need sudo to be installed to make this script work (and to be in the group)

echo "-------------------------------------------"
echo "General purpose Debian installation script "
echo "-------------------------------------------"

# Standard error mitigation

set -euo pipefail

# Add repositories

sudo apt install -y software-properties-common
sudo add-apt-repository contrib non-free

# Update software

sudo apt update
sudo apt -y upgrade

# Install some basic utilities

sudo apt install -y htop git byobu synaptic xautolock shellcheck xinit kitty zathura pcmanfm irssi mplayer network-manager-gnome rsync neofetch curl

# Install the i3 window manager and some basic utilities (all of these are referenced in my i3 config file, so need to be installed)

sudo apt install -y i3 i3blocks feh arandr scrot xautolock barrier kitty imagemagick polybar caffeine copyq picom

# Set up i3. Comment this out if you want to use your own config file or build your config from scratch.

wget https://raw.githubusercontent.com/teknostatik/i3_config/main/config
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/lock.sh
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/kitty.conf
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/picom.conf
mkdir /home/andy/.config/i3
mv config /home/andy/.config/i3/
sudo mv lock.sh /usr/local/bin/
mkdir /home/andy/.config/kitty
mv kitty.conf /home/andy/.config/kitty/
mkdir /home/andy/.config/picom
mv picom.conf /home/andy/.config/picom/

# Set up i3 wallpaper

sudo mkdir /usr/share/wallpaper

# Copy any existing wallpapers into this new directory (delete any you don't like later)

sudo cp -R /usr/share/backgrounds/* /usr/share/wallpaper

# In my i3 config file we switch wallpaper using MOD + Z, but this requires a script

cd $HOME
wget https://raw.githubusercontent.com/teknostatik/i3_config/main/randomise_wallpaper
sudo mv randomise_wallpaper /usr/local/bin/
sudo chmod 755 /usr/local/bin/randomise_wallpaper

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

# Install the applications I use for writing, editing and previewing text

sudo apt install -y pandoc texlive texlive-latex-extra
sudo apt-get install gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

# Install some desktop applications for creating, editing and playing common media types

sudo apt install -y gimp rhythmbox vlc brasero sound-juicer

# Install Flatpak

# sudo apt install -y flatpak gnome-software-plugin-flatpak
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install some flatpaks

# flatpak install flathub com.visualstudio.code -y
# flatpak install flathub com.firefox -y
# flatpak install flathub org.nickvision.tubeconverter -y

# Install snapd
# Most people won't do this, but I think documenting a working installation of this is important

# sudo apt install -y snapd
# sudo snap install core
# sudo ln -s /var/lib/snapd/snap /snap

# Install some snaps

# sudo snap install tube-converter
# sudo snap install unixbench

# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Install drivers for Displaylink docking stations, such as the lenovo and Dell ones I use at home and work

git clone https://github.com/AdnanHodzic/displaylink-debian.git
cd displaylink-debian
sudo ./displaylink-debian.sh
cd ..

# Set up git

git config --global user.name "Andy Ferguson"
git config --global user.email "andy@teknostatik.org"

# install ProtonVPN

wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb
sudo dpkg -i protonvpn-stable-release_1.0.3-2_all.deb
sudo apt update
sudo apt install -y proton-vpn-gnome-desktop

# Install Zerotier

curl -s https://install.zerotier.com | sudo bash

# Download unixbench

sudo apt-get install libx11-dev libgl1-mesa-dev libxext-dev perl perl-modules make git
git clone https://github.com/kdlucas/byte-unixbench.git
# uncomment tne next 2 lines to run the benchmark now
# cd byte-unixbench/UnixBench/
# ./Run

# Download and install Dropbox

sudo apt install -y nautilus-dropbox
dropbox start -i

echo "The script has now finished running."
