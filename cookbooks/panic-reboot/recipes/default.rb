#
# Cookbook Name:: panic-reboot
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "panic-reboot" do
  path "/etc/sysctl.d/10-panic-reboot.conf"
  source "panic-reboot.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[sysctl reload]" 
end

# execute — Chef Docs http://docs.opscode.com/resource_execute.html
execute "sysctl reload" do
  command "sysctl --system --load"
  # Run only when another resource notifies.
  action :nothing
end
