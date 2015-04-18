compiler_path = node['gnustep']['compiler']
bash 'compile-make' do
	cwd node['gnustep']['devel-dir']

		export CC=#{compiler_path}
		echo $CC
	code <<-EOH
	EOH
end
