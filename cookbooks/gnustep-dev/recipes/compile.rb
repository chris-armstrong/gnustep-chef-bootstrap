#    compile.rb - compile the GNUstep core source code
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

bash 'compile-gui' do
    cwd gnustep_gui_code_path
    code <<-EOH
        . #{gnustep_sh}
        export "CC=#{compiler_path}"
        
        ./configure 
        #{make_path} && sudo -E #{make_path} install
    EOH
    user devel_user
    group devel_user
end

bash 'compile-back' do
    cwd gnustep_back_code_path
    code <<-EOH
        . #{gnustep_sh}
        export "CC=#{compiler_path}"
        
        ./configure 
        #{make_path} && sudo -E #{make_path} install
    EOH
    user devel_user
    group devel_user
end