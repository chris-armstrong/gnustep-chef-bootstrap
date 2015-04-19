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

tiff_package = value_for_platform_family(
    [ 'debian' ] => 'libtiff5-dev'
)
package tiff_package

png_package = value_for_platform_family(
    [ 'debian' ] => 'libpng12-dev'
)
package png_package

cups_package = value_for_platform_family(
    [ 'debian' ] => 'libcups2-dev'
)
package cups_package

# libdispatch is needed by cupsys because libobjc2 defines __BLOCKS__, which
# triggers (surprise surprise) Apple code in the cups header to include libdispatch, which cups
# isn't built against on Ubuntu. I don't think this causes any harm, as 
# gnustep-gui doesn't seem to link against it.
libdispatch_package = value_for_platform(
    [ 'ubuntu' ] => { '14.04' => 'libdispatch-dev' },
    'default' => false
)
package libdispatch_package if libdispatch_package

# BACK
#
cairo_package = value_for_platform_family(
    [ 'debian' ] => 'libcairo2-dev'
)
package cairo_package

xrender_package = value_for_platform_family(
    [ 'debian' ] => 'libxrender-dev'
)
package xrender_package

xlib_package = value_for_platform_family(
    [ 'debian' ] => 'libx11-dev'
)
package xlib_package

xt_package = value_for_platform_family(
    [ 'debian' ] => 'libxt-dev'
)
package xt_package

# X-WINDOW-SYSTEM - make a basic X Server, XDM, WM and terminal available
if platform_family?('debian')
    xwindowsystem_package = value_for_platform(
        [ 'ubuntu' ] => { '14.04' => 'xserver-xorg' }
    )
    package xwindowsystem_package
    package 'wmaker'
    package 'xterm'
    package 'xdm'
end