require 'date'

yesterday = DateTime.now().prev_day()
svn_snapshot_datestring = yesterday.strftime("%Y%m%d")

devel_dir = "/home/vagrant/gnustep"
node['gnustep']['devel-dir'] = devel_dir
snapshots_url = "ftp://ftp.gnustep.org/pub/daily-snapshots/"
directory devel_dir

log "downloading snapshot #{svn_snapshot_datestring}"

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
			svn upgrade
		EOH
		not_if { ::File.exists?(module_extract_path) }
	end

	subversion "update_#{module_name}" do
		destination module_extract_path
		repository "http://svn.gna.org/svn/gnustep/modules/#{module_name}"
		action :sync
	end

end


