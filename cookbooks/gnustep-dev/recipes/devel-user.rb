devel_user = node['gnustep']['devel_user']
user devel_user do
    comment 'GNUstep Development User'
    gid 'users'
    supports :manage_home => true
    home "/home/#{devel_user}"
    shell '/bin/bash'
    password "$1$kqhTLGKh$By/GYBIVN9.luXB75IDFb." # stepper1
end

group devel_user do
    action :create
    members devel_user
end

# Give user sudo privileges without passwd
template "/etc/sudoers.d/#{devel_user}" do
    source 'devel_user-sudo.erb'
    mode '0440'
    user 'root'
    group 'root'
    variables({
        :user => "#{devel_user}"
    })
end