#!/bin/bash

# Script to run after installing Debian from the netinstall iso with a Gnome desktop
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

# Remove some things we don't need

sudo apt remove -y gnome-games
sudo apt autoremove -y

# Update software

sudo apt update
sudo apt -y upgrade

# Install some basic utilities

sudo apt install -y htop git byobu synaptic xautolock shellcheck xinit zathura network-manager-gnome rsync curl ttf-mscorefonts-installer build-essential gimp rhythmbox vlc brasero sound-juicer lxappearance flameshot pandoc texlive texlive-latex-extra abiword remmina

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

# Some optional packages, which users can choose to install

# Function to install vscode
install_vscode() {
    sudo apt-get install -y gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/packages.microsoft.gpg > /dev/null
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y code
}

# Function to install and configure i3
install_i3() {
    sudo apt-get install -y i3 i3blocks feh arandr scrot xautolock barrier kitty imagemagick polybar caffeine copyq picom blueman pcmanfm
    wget -q https://raw.githubusercontent.com/teknostatik/i3_config/main/config -O /tmp/i3_config
    wget -q https://raw.githubusercontent.com/teknostatik/i3_config/main/lock.sh -O /usr/local/bin/lock.sh
    wget -q https://raw.githubusercontent.com/teknostatik/i3_config/main/kitty.conf -O /tmp/kitty.conf
    wget -q https://raw.githubusercontent.com/teknostatik/i3_config/main/picom.conf -O /tmp/picom.conf
    mkdir -p /home/$USER/.config/i3 /home/$USER/.config/kitty /home/$USER/.config/picom
    mv /tmp/i3_config /home/$USER/.config/i3/config
    mv /tmp/kitty.conf /home/$USER/.config/kitty/kitty.conf
    mv /tmp/picom.conf /home/$USER/.config/picom/picom.conf
    sudo install -D -o root -g root -m 755 /usr/local/bin/lock.sh /usr/local/bin/lock.sh
    sudo mkdir -p /usr/share/wallpaper
    sudo cp -R /usr/share/backgrounds/* /usr/share/wallpaper
    wget -q https://raw.githubusercontent.com/teknostatik/i3_config/main/randomise_wallpaper -O /usr/local/bin/randomise_wallpaper
    sudo chmod 755 /usr/local/bin/randomise_wallpaper
}

# Function to install tor
install_tor() {
    sudo apt-get install -y torbrowser-launcher onionshare
}

# Function to install DisplayLink
install_displaylink() {
    git clone https://github.com/AdnanHodzic/displaylink-debian.git /tmp/displaylink-debian
    echo "Do not reboot when given the option. You will need to reboot before trying to use your docking station."
    sudo /tmp/displaylink-debian/displaylink-debian.sh
    wget -q https://raw.githubusercontent.com/teknostatik/debian/master/20-displaylink.conf -O /etc/X11/xorg.conf.d/20-displaylink.conf
    rm -rf /tmp/displaylink-debian
}

# Function to install snapd
install_snapd() {
    sudo apt-get install -y snapd
    sudo snap install core
    sudo ln -s /var/lib/snapd/snap /snap
}

# Function to install flatpak
install_flatpak() {
    sudo apt-get install -y flatpak gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

# Function to install ProtonVPN
install_protonvpn() {
    wget -q https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb -O /tmp/protonvpn.deb
    sudo dpkg -i /tmp/protonvpn.deb
    sudo apt-get update
    sudo apt-get install -y proton-vpn-gnome-desktop
    rm /tmp/protonvpn.deb
}

# Function to install Zerotier 
install_zerotier() {
    curl -s https://install.zerotier.com | sudo bash
}

# Function to install Unixbench
install_unixbench() {
    sudo apt-get install libx11-dev libgl1-mesa-dev libxext-dev perl perl-modules make git
    git clone https://github.com/kdlucas/byte-unixbench.git
# uncomment tne next 2 lines to run the benchmark now
# cd byte-unixbench/UnixBench/
# ./Run
}

# Fuction to install Dropbox
install_dropbox() {
    sudo apt install -y nautilus-dropbox
    dropbox start -i
}

# Prompt function
prompt_install() {
    read -p "Do you want to install $1? (yes/no): " choice
    if [[ "$choice" == "yes" ]]; then
        $2
    fi
}

# Main script to prompt user and call installation functions
prompt_install "Visual Studio Code" install_vscode
prompt_install "i3 tiling window manager" install_i3
prompt_install "Tor browser and Onionshare" install_tor
prompt_install "DisplayLink docking station support" install_displaylink
prompt_install "snapd" install_snapd
prompt_install "flatpak" install_flatpak
prompt_install "ProtonVPN" install_protonvpn
prompt_install "Zerotier" install_zerotier
prompt_install "Unixbench" install_unixbench
prompt_install "Dropbox" install_dropbox

# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Set up git 
# This only works if you are me, which I'll fix at some point

git config --global user.name "Andy Ferguson"
git config --global user.email "andy@teknostatik.org"



