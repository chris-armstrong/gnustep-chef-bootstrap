default['make']['path'] = value_for_platform(
    ['freebsd'] => { "default" => "gmake" },
    "default" => "make"
)