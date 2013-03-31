#
# Cookbook Name:: pt3
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# git — Chef Docs http://docs.opscode.com/resource_git.html
git "#{Chef::Config[:file_cache_path]}/pt3" do
  repository "/arc/repos/pt3.git"
  reference "master"
  action :sync
  notifies :run, "bash[install]"
end

bash "install" do
  cwd "#{Chef::Config[:file_cache_path]}/pt3"
  code <<-EOH
    make install
    rmmod pt3_drv
    modprobe pt3_drv
  EOH
  action :nothing
end

bash "module" do
  not_if "grep pt3_drv /etc/modules"
  code <<-EOC
    echo pt3_drv >> /etc/modules
  EOC
end

template "pt3.conf" do
  path "/etc/modprobe.d/pt3.conf"
  source "pt3.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

