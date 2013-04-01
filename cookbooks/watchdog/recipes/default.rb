# -*- encoding: utf-8 -*-
#
# Cookbook Name:: watchdog
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# package — Chef Docs http://docs.opscode.com/resource_package.html
package "watchdog" do
  package_name "watchdog"
  action :install
end

service "watchdog" do
  action [ :enable , :start ]
  # "restart" does not load the module
  supports :status => true, :restart => false, :reload => false
end

template "watchdog" do
  path "/etc/watchdog.conf"
  source "watchdog.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "watchdog")
end

template "watchdog service" do
  path "/etc/default/watchdog"
  source "watchdog.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "watchdog")
end


bash "watchdog boot time module loading" do
  not_if "grep #{node["watchdog"]["module"]} /etc/modules"
  code <<-EOC
    echo #{node["watchdog"]["module"]} >> /etc/modules
  EOC
end
