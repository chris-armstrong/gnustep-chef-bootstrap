#    gnustep.rb - define attributes for GNUstep development
#    Copyright (C) 2015  Chris Armstrong
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# devel_user: The development user to setup
default['gnustep']['devel_user'] = "dev"

# devel_dir: the directory gnustep sources will be checked out and built
default['gnustep']['devel_dir'] = "/home/#{default['gnustep']['devel_user']}/gnustep"

default['gnustep']['prefix'] = "/GNUstep"

# Assume compiler is always clang
default['gnustep']['compiler'] = "clang"
default['gnustep']['compiler_path'] = default['clang']['compiler_path']