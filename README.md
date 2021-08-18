# Debian Post-installation Script

This is a fork of my [Ubuntu scripts](https://github.com/teknostatik/deploy_ubuntu).

Very much a work in progress, and I wouldn't recommend running this on a machine you care about.

## Installation

Before you run this script ensure that you have `sudo` installed and that your user is in the group. To do this run the following as root (replacing `<your username>` with your username)

    apt install -y sudo
    sudo usermod -aG sudo <your username>

You will also need some extra repositories enabled. My `/etc/apt/sources.list` looks like this:

    deb http://deb.debian.org/debian bullseye main contrib non-free
    deb http://security.debian.org/debian-security bullseye/updates main contrib non-free


Then download the script and make it executable:

    wget https://raw.githubusercontent.com/teknostatik/debian/master/deploy_debian.sh
    chmod 755 deploy_debian.sh
    ./deploy_debian.sh

I've tested this on top of a full desktop install and a command line only installation as well. My goal is to get a working i3 environment so the latter is probably what I'm going to focus on going forward.

Now Bullseye is released I'll probably spend a bit more time on this and am now running this exact build on one of my computers. 
