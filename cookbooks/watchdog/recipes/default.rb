#
# Cookbook Name:: watchdog
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "watchdog" do
  path "/etc/default/watchdog"
  source "watchdog.erb"
  owner "root"
  group "root"
  mode "0644"
end
