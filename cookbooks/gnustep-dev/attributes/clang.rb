# binary_versions: the list of versions of clang for which packaged binaries are available
default['clang']['binary_versions'] = value_for_platform(
	[ 'ubuntu' ] => { '14.04' => [ '3.3', '3.4', '3.5' ] } # Ubuntu 14.04 clang-3.5 package has CMake installation issues
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