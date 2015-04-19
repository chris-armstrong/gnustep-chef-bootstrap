# devel_user: The development user to setup
default['gnustep']['devel_user'] = "dev"

# devel_dir: the directory gnustep sources will be checked out and built
default['gnustep']['devel_dir'] = "/home/#{default['gnustep']['devel_user']}/gnustep"

default['gnustep']['prefix'] = "/GNUstep"

# Assume compiler is always clang
default['gnustep']['compiler'] = "clang"
default['gnustep']['compiler_path'] = default['clang']['compiler_path']