# gnustep-chef-bootstrap

This is a Vagrant configuration together with a Chef cookbook for creating a GNUstep virtual machine suitable for development. It currently only supports a guest of Ubuntu 14.04 with x86_64. It will download a template virtual machine, and then configure the prerequisite packages before downloading and compiling the
GNUstep source code. It also creates a development user and installs XWindows with Window Maker window manager for use.

## Getting Started

You have two main options for using this Vagrantfile and Chef cookbook:

* *(RECOMMENDED)* Install Vagrant and VirtualBox and use the accompanying Vagrantfile to create and configure the VM 
* Use an existing virtual machine with a supported OS and bootstrap the chef cookbook without Vagrant

The first option is strongly recommended as it has been tested and Vagrant has tools that make it easy to destroy and rebuild the VM if the bootstrap process
fails. If you do plan to use an existing Ubuntu virtual machine, take a snapshot or make a backup in case the installation process fails and leaves your VM in an inconsistent state.

Do not bootstrap the Chef cookbook on your day-to-day workstation - if anything goes wrong, there is no "undo" script. It also creates a user with a well-defined password, which an insecure configuration for a workstation environment. 

## Supported Guest OSs

At the moment, it only supports Ubuntu 14.04 Trusty x86_64. There are plans to support more Linux versions and other operating systems. Other Linux variants
(and Ubuntu versions) will simply fail at this point in time.

## Requirements for Host Workstation

* Vagrant (http://www.vagrantup.com/downloads.html)
* Oracle VirtualBox (https://www.virtualbox.org/wiki/Downloads)
* At least 3.5GB free disk space
* 1GB RAM for the virtual machine
* Windows, Linux or MacOS X
* Broadband internet connection (and if data limited, be aware that several hundred megabytes of data will be downloaded)

Both of the above are only available on Windows, Linux and MacOS X (VirtualBox supports more platforms, but you would not be able to use Vagrant to 
bootstrap the VM).

If running on Windows, Vagrant commands such as "vagrant ssh" work better with a cygwin installation (although this is not mandatory: you can SSH to the VM
using PuTTY after converting the key and adding it to Paegent).

The cookbook is tested to run in chef-client local mode - you shouldn't require a Chef server to coordinate this cookbook.

## Usage (Vagrant+Chef)

1. Install Vagrant on your host workstation
2. Install VirtualBox on your host workstation
3. At the command line, execute:

        cd gnustep-chef-bootstrap/ubuntu/14.04/x86_64
        vagrant up

    The `vagrant up` command will download a template VM from the Vagrant Atlas repository, then start it up, install chef, and then begin the provisioning with the cookbooks/gnustep-dev chef cookbook. It also creates a 'dev' user for performing development with.

4. The Vagrantfile is configured to show the VirtualBox VM window (by default it is hidden). You can switch to a virtual terminal and login as the 'dev' user (
be warned that *this user has nopasswd sudo access*)
   * Username: dev
   * Password: stepper1

5. The VM installs X Windows and a window manager (Window Maker). If you reboot the VM (or run "sudo service xdm start"), you can login using XDM instead
of at a virtual terminal.

6. If you ever need to SSH to the VM to perform admin, you can run the following command to SSH in.

        vagrant ssh

## Usage (Chef cookbook only)

If you just want to run this on an existing Ubuntu 14.04 installation, you can install chef and then execute the cookbook manually (note you require
sudo access):

1. Install chef 

        curl -L https://www.chef.io/chef/install.sh | sudo bash

2. Use git to download the cookbook or extract it from a zip file
3. Run the cookbook using chef-client local mode

        cd cookbooks/gnustep-dev
        sudo chef-client --local-mode -o gnustep-dev

## License

    Copyright (C) Chris Armstrong 2015.
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.