#    clang.rb - define attributes for clang installation
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

# binary_versions: the list of versions of clang for which packaged binaries are available
default['clang']['binary_versions'] = value_for_platform(
	[ 'ubuntu' ] => { '14.04' => [ '3.3', '3.4', '3.5' ] } # Ubuntu 14.04 clang-3.5 package has CMake installation issues (see https://bugs.launchpad.net/ubuntu/+source/llvm/+bug/1387011)
)
# binary_default_version: the default version of a packaged binary of clang
default['clang']['binary_default_version'] = value_for_platform(
	[ 'ubuntu' ] => { '14.04' => '3.4' },
	'default' => 'no-binary-available'
)

# binary_package: the name of the packaged binary for clang
default['clang']['binary_package'] = value_for_platform(
	[ 'ubuntu' ] =>  { "default" => "clang-#{default['clang']['binary_default_version']}" },
	'default' => 'clang-nobinary'
)

# FIXME: Make this an overridable attribute
default['clang']['selected_binary_version'] = default['clang']['binary_default_version']

default['clang']['binary_available'] = true if default['clang']['binary_package'] != 'clang-nobinary' 


# TODO: need to get compiler path based on where clang is installed
# if we compile from source
default['clang']['compiler_path'] = value_for_platform(
	[ 'ubuntu' ] => { "14.04" => "clang" }
)