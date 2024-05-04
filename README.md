# Debian Post-installation Script

This is a fork of my [Ubuntu scripts](https://github.com/teknostatik/deploy_ubuntu).

I have run this on three computers now, and it give sme everything I need to be productive. As always, your milage may vary.

## Installation

Before you run this script ensure that you have `sudo` installed and that your user is in the group. To do this run the following as root (replacing `<your username>` with your username)

    apt install -y sudo
    sudo usermod -aG sudo <your username>

Or alternately, install Debian without a root password and this step shouldn't be required.

Then download the script and make it executable:

    wget https://raw.githubusercontent.com/teknostatik/debian/master/deploy_debian.sh
    chmod 755 deploy_debian.sh
    ./deploy_debian.sh
