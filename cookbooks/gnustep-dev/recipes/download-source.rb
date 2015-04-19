#    download-source.rb - recipe to download source code for GNUstep
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

require 'date'

# Calculate snapshot time as yesterday in case we run this
# recipe in a Asia Pacific timezone (which may be a day ahead
# of U.S. timezones)
yesterday = DateTime.now().prev_day()
svn_snapshot_datestring = yesterday.strftime("%Y%m%d")

devel_dir = node['gnustep']['devel_dir']
devel_user = node['gnustep']['devel_user']
snapshots_url = "ftp://ftp.gnustep.org/pub/daily-snapshots/"

directory devel_dir do
    owner devel_user
    group devel_user
end

log "downloading snapshot #{svn_snapshot_datestring}"

# download, extract, upgrade and update SVN snapshots that
# are needed
[ 'core', 'dev-libs' ].each do | module_name |

	module_filename = "#{module_name}.#{svn_snapshot_datestring}.tar.bz2"
	module_filepath = "#{Chef::Config['file_cache_path']}/#{module_filename}"
	module_extract_path = devel_dir + "/" + module_name

	remote_file module_filepath do
		source snapshots_url+module_filename
		not_if { ::File.exists?(module_extract_path) || ::File.exists?(module_filepath) }
	end
    
 	bash "extract_#{module_name}" do
		cwd ::File.dirname(module_filepath)
		code <<-EOH
			tar xjf #{module_filename} -C #{devel_dir}
			cd #{module_extract_path}
			chown -R #{devel_user}.#{devel_user} .
            sudo -u #{devel_user} svn --config-dir /home/#{devel_user}/.subversion upgrade
		EOH
 		not_if { ::File.exists?(module_extract_path) }
	end

    bash "update_#{module_name}" do
        cwd module_extract_path
        code <<-EOH
            svn --config-dir /home/#{devel_user}/.subversion update
        EOH
        user devel_user
        group devel_user
    end
end


