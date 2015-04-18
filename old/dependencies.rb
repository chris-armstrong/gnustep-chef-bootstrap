# SVN
#
subversion_package = value_for_platform(
	'default' => 'subversion'
)
package subversion_package

# COMPILER
clang_binary_versions = value_for_platform(
	[ 'ubuntu' ] => { '14.04' => [ '3.3', '3.4', '3.5' ] }
)

clang_binary_default_version = value_for_platform(
	[ 'ubuntu' ] => { '14.04' => '3.5' },
	'default' => 'no-binary-available'
)

clang_binary_package = value_for_platform(
	[ 'ubuntu' ] =>  { "14.04" => "clang-#{clang_binary_default_version}" },
	'default' => 'clang-nobinary'
)

# FIXME: Make this an overridable attribute
clang_binary_version = clang_binary_default_version
clang_binary_available = true if clang_binary_package != 'clang-nobinary' 

package clang_binary_package do 
	only_if { clang_binary_available }
end

# FIXME: need to get compiler path based on where clang is installed
# if we compile from source
compiler_path = value_for_platform(
	[ 'ubuntu' ] => "clang-#{clang_binary_version}"
)

node['gnustep']['compiler'] = compiler_path

# BUILD UTILITIES
#

make_package = value_for_platform_family(
	[ 'debian' ] => 'make'
)
package make_package

autoconf_package = value_for_platform_family(
	[ 'debian' ] => 'autoconf'
)
package autoconf_package

automake_package = value_for_platform_family(
	[ 'debian' ] => 'automake'
)
package automake_package

# GUI DEPENDENCIES
#
jpeg_package = value_for_platform_family(
	[ 'debian' ] => 'libjpeg62'
)

package jpeg_package


