# -*- encoding: utf-8 -*-
#
# Cookbook Name:: watchdog
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "watchdog" do
  action :install
end

template "watchdog" do
  path "/etc/default/watchdog"
  source "watchdog.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[watchdog]"
end

template "watchdog.conf" do
	path "/etc/watchdog.conf"
	source "watchdog.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	notifies :restart, "service[watchdog]"
end

service "watchdog" do
  action [ :enable , :start ]
  # "restart" does not load the module
  supports :status => true, :restart => false, :reload => false
end
