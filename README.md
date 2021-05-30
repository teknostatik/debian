# Debian Post-installation Script

This is a fork of my [Ubuntu scripts](https://github.com/teknostatik/deploy_ubuntu).

Very much a work in progress, and I wouldn't recommend running this on a machine you care about.

## Installation

Before you run this script ensure that you have `sudo` installed and that your user is in the group. To dothis run the following as root (replacing `<your username>` with your username)

    apt install -y sudo
    sudo usermod -aG sudo <your username>

You will also need some extra repositories enabled. My `/etc/apt/sources.list` looks like this:

    deb http://deb.debian.org/debian bullseye main contrib non-free
    deb http://security.debian.org/debian-security bullseye/updates main contrib non-free


Then download the script and make it executable:

    wget https://raw.githubusercontent.com/teknostatik/debian/master/deploy_debian.sh
    chmod 755 deploy_debian.sh
    ./deploy_debian.sh
