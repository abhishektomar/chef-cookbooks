#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2015, ABHISHEK TOMAR
#
# All rights reserved - Do Not Redistribute

package "php5" do
  package_name node["php"]["package"]
end

cookbook_file "/etc/php.ini" do
  source "php.ini"
  mode "0644"
end
