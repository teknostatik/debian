#!/bin/bash

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
    sudo apt install -y i3 i3blocks feh arandr scrot xautolock barrier kitty imagemagick polybar caffeine copyq picom blueman
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

