#    devel-user.rb - recipe to create development user
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

devel_user = node['gnustep']['devel_user']
user devel_user do
    comment 'GNUstep Development User'
    gid 'users'
    supports :manage_home => true
    home "/home/#{devel_user}"
    shell '/bin/bash'
    password "$1$kqhTLGKh$By/GYBIVN9.luXB75IDFb." # stepper1
end

group devel_user do
    action :create
    members devel_user
end

# Give user sudo privileges without passwd
template "/etc/sudoers.d/#{devel_user}" do
    source 'devel_user-sudo.erb'
    mode '0440'
    user 'root'
    group 'root'
    variables({
        :user => "#{devel_user}"
    })
end