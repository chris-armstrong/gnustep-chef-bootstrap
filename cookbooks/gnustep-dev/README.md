# gnustep-dev

This cookbook configures a GNUstep development environment. Installs required packages, downloads source code snapshots from SVN and then compiles and installs the GNUstep libraries. It also creates a user called 'dev' and configures and installs the XWindow System with Window Maker as window manager and XDM for login.

''It is strongly recommended that you do not use this cookbook on production systems - use a VM (such as with the accompanying Vagrantfiles)''

## Prerequisites

* No other cookbook dependencies
* Should be usable with modern chef installations, but only tested with Chef 12 in chef-client local mode

## Usage

This cookbook is designed to be used from one of the Vagrantfiles above this cookbook directory. Otherwise, it should be executed locally using chef-client:

cd cookbooks/gnustep-dev
sudo chef-client -z -o gnustep-dev

After the cookbook has executed, a new user called "dev" is created. You can login using the credentials:
  Username: dev
  Password: stepper1

## Supported platforms

* Ubuntu 14.04 x86_64

## License

    Copyright (C) Chris Armstrong 2015.
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
