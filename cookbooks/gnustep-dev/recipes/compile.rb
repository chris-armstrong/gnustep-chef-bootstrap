compiler_path = node['gnustep']['compiler_path']
make_path = node['make']['path']

devel_dir = node['gnustep']['devel_dir']
devel_user = node['gnustep']['devel_user']
gnustep_install_prefix = node['gnustep']['prefix']

gnustep_make_code_path =  "#{devel_dir}/core/make"
gnustep_base_code_path = "#{devel_dir}/core/base"
gnustep_gui_code_path = "#{devel_dir}/core/gui"
gnustep_back_code_path = "#{devel_dir}/core/back"
gnustep_libobjc2_code_path = "#{devel_dir}/dev-libs/libobjc2"

gnustep_sh = "#{gnustep_install_prefix}/System/Library/Makefiles/GNUstep.sh"

bash 'compile-make' do
	cwd gnustep_make_code_path
    code <<-EOH
		export "CC=#{compiler_path}"
		echo $CC
        # FIXME: non-fragile-abi / objc2 is not suitable for gcc-only platforms
        ./configure --prefix=#{gnustep_install_prefix} --with-layout=gnustep --enable-debug-by-default --enable-objc-nonfragile-abi
        #{make_path}
        sudo -E #{make_path} install
	EOH
    user devel_user
    group devel_user
    not_if { ::File.exists?(gnustep_install_prefix) }
end

libobjc2_cmake_clang_flags = "-DCMAKE_C_COMPILER=#{compiler_path} -DCMAKE_CXX_COMPILER=#{compiler_path} -DCMAKE_ASM_COMPILER=#{compiler_path} -DCMAKE_ASM_FLAGS=-c -DTESTS=OFF"
bash 'prepare-libobjc2' do
    cwd gnustep_libobjc2_code_path
    code <<-EOH
        rm -rf Build
        mkdir Build
        cd Build
        cmake #{libobjc2_cmake_clang_flags} ..
    EOH
    user devel_user
    group devel_user
end

bash 'compile-libobjc2' do
    cwd gnustep_libobjc2_code_path
    code <<-EOH
        . #{gnustep_sh}
        export "CC=#{compiler_path}"
        cd Build
        #{make_path} -j2 && sudo -E #{make_path} install && sudo ldconfig
    EOH
    user devel_user
    group devel_user
end

bash 'recompile-make' do
    cwd gnustep_make_code_path
    code <<-EOH
        . #{gnustep_sh}
		export "CC=#{compiler_path}"
		export "LDFLAGS=-L/usr/local/lib" # needed for libobjc2 discovery
        # FIXME: non-fragile-abi / objc2 is not suitable for gcc-only platforms
        ./configure --prefix=#{gnustep_install_prefix} --with-layout=gnustep --enable-debug-by-default --enable-objc-nonfragile-abi
        #{make_path} && sudo -E #{make_path} install
	EOH
    user devel_user
    group devel_user
end

bash 'compile-base' do
    cwd gnustep_base_code_path
    code <<-EOH
        . #{gnustep_sh}
        export "CC=#{compiler_path}"
        
        ./configure --disable-mixedabi
        #{make_path} && sudo -E #{make_path} install
    EOH
    user devel_user
    group devel_user
end
