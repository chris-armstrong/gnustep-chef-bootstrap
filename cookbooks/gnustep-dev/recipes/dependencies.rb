# SVN
#
subversion_package = value_for_platform(
	'default' => 'subversion'
)
package subversion_package

# COMPILER
package node['clang']['binary_package'] do 
	only_if { node['clang']['binary_available'] }
end

# BUILD UTILITIES
#

make_package = value_for_platform_family(
	[ 'debian' ] => 'make',
    "default" => "make"
)
package make_package

cmake_package = value_for_platform_family(
    [ 'debian' ] => 'cmake',
    "default" => "cmake"
)
package cmake_package

autoconf_package = value_for_platform_family(
	[ 'debian' ] => 'autoconf'
)
package autoconf_package

automake_package = value_for_platform_family(
	[ 'debian' ] => 'automake'
)
package automake_package

# BASE DEPENDENCIES
#
libffi_package = value_for_platform_family(
    [ 'debian' ] => 'libffi-dev'
)
package libffi_package

libxml2_package = value_for_platform_family(
    [ 'debian' ] => 'libxml2-dev'
)
package libxml2_package

libxslt_package = value_for_platform_family(
    [ 'debian' ] => 'libxslt1-dev'
)
package libxslt_package

libgnutls_package = value_for_platform_family(
    ['debian'] => 'libgnutls-dev'
)
package libgnutls_package

libicu_package = value_for_platform_family(
    [ 'debian' ] => 'libicu-dev'
)
package libicu_package

# GUI DEPENDENCIES
#
jpeg_package = value_for_platform_family(
	[ 'debian' ] => 'libjpeg62'
)

package jpeg_package


