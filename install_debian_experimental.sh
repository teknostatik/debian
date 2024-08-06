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

# Function to install vscode
install_vscode() {
    sudo apt-get install gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code
}

# Function to install and configure i3
install_i3() {
    sudo apt install -y i3 i3blocks feh arandr scrot xautolock barrier kitty imagemagick polybar caffeine copyq picom blueman pcmanfm 
    wget https://raw.githubusercontent.com/teknostatik/i3_config/main/config
    wget https://raw.githubusercontent.com/teknostatik/i3_config/main/lock.sh
    wget https://raw.githubusercontent.com/teknostatik/i3_config/main/kitty.conf
    wget https://raw.githubusercontent.com/teknostatik/i3_config/main/picom.conf
    mkdir /home/$WHOAMI/.config/i3
    mv config /home/$WHOAMI/.config/i3/
    sudo mv lock.sh /usr/local/bin/
    mkdir /home/$WHOAMI/.config/kitty
    mv kitty.conf /home/$WHOAMI/.config/kitty/
    mkdir /home/$WHOAMI/.config/picom
    mv picom.conf /home/$WHOAMI/.config/picom/
    sudo mkdir /usr/share/wallpaper
    sudo cp -R /usr/share/backgrounds/* /usr/share/wallpaper
    cd $HOME
    wget https://raw.githubusercontent.com/teknostatik/i3_config/main/randomise_wallpaper
    sudo mv randomise_wallpaper /usr/local/bin/
    sudo chmod 755 /usr/local/bin/randomise_wallpaper
}

# Function to install tor
install_tor() {
    sudo apt install -y torbrowser-launcher onionshare
}

# Function to install DisplayLink
install_displaylink() {
    git clone https://github.com/AdnanHodzic/displaylink-debian.git
    cd displaylink-debian
    sudo ./displaylink-debian.sh
    wget https://raw.githubusercontent.com/teknostatik/debian/master/20-displaylink.conf
    sudo mv 20-displaylink.conf /etc/X11/xorg.conf.d/
    cd ..
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

# Prompt the user for VScode installation
echo "Do you want to install Visual Studio Code? (yes/no)"
read vscode_choice

if [[ "$vscode_choice" == "yes" ]]; then
    install_vscode
fi

# Prompt the user for i3 installation
echo "Do you want to install and configure the i3 tiling window manager? (yes/no)"
read i3_choice

if [[ "$i3_choice" == "yes" ]]; then
    install_i3
fi

# Prompt the user for tor installation
echo "Do you want to install and configure Tor browser and Onionshare? (yes/no)"
read tor_choice

if [[ "$tor_choice" == "yes" ]]; then
    install_tor
fi

# Prompt the user for DisplayLink installation
echo "Will you be using a DisplayLink docking station on this computer? (yes/no)"
read displaylink_choice

if [[ "$displaylink_choice" == "yes" ]]; then
    install_displaylink
fi

# Prompt the user for snapd installation
echo "Do you want to install snapd? (yes/no)"
read snapd_choice

if [[ "$snapd_choice" == "yes" ]]; then
    install_snapd
fi

# Prompt the user for flatpak installation
echo "Do you want to install flatpak? (yes/no)"
read flatpak_choice

if [[ "$flatpak_choice" == "yes" ]]; then
    install_flatpak
fi

# Add some aliases

echo "alias ls='ls -la'" >> .bashrc
echo "alias top='htop'" >> .bashrc

# Set up git

git config --global user.name "Andy Ferguson"
git config --global user.email "andy@teknostatik.org"



