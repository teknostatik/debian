# Debian Post-installation Script

This is a fork of my [Ubuntu scripts](https://github.com/teknostatik/deploy_ubuntu).

I have run this on three computers now, and it gives me everything I need to be productive. As always, your milage may vary.

## Installation

Before you run this script ensure that you have `sudo` installed and that your user is in the group. To do this run the following as root (replacing `<your username>` with your username)

    apt install -y sudo
    sudo usermod -aG sudo <your username>

Or alternately, install Debian without a root password and this step shouldn't be required.

Then download the script and make it executable:

    wget https://raw.githubusercontent.com/teknostatik/debian/master/deploy_debian.sh
    chmod 755 deploy_debian.sh
    ./deploy_debian.sh

## Versions

As well as the desktop version, there is now [a script to install a server](https://github.com/teknostatik/debian/blob/master/deploy_server.sh). This has no graphical applications at all, but does have an SSH server to allow remote access. I'd recommend _not_ enabling full-disk encryption on this one if you plan on administering it remotely.

## Note

In both of these scripts there are additional options that are commented out because I don't use them by default, but which might be useful later. 
