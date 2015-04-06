#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, ABHISHEK TOMAR
#
# All rights reserved - Do Not Redistribute
#
if node["platform"] == "ubuntu"
  execute "apt-get update -y" do
  end
end

package "apache2" do
  package_name node["apache"]["package"]
end

node["apache"]["sites"].each do |sitename, data|
	document_root = "/var/www/#{sitename}"

	directory document_root do
		mode "0755"
		recursive true
	end

  if node["platform"] == "ubuntu"
    template_location = "/etc/apache2/sites-available/#{sitename}.conf"
  elsif node["platform"] == "centos"
    template_location = "/etc/httpd/conf.d/#{sitename}.conf"
  end

  template template_location do
    source "vhost.erb"
    mode "0644"
    variables(
            :document_root => document_root,
            :port => data["port"],
            :domain => data["domain"]
    )
  end

  if node["platform"] == "ubuntu"
    bash 'enable_website' do
      code <<-EOH
        ln -s "/etc/apache2/sites-available/#{sitename}.conf" "/etc/apache2/sites-enabled/#{sitename}.conf"
      EOH
      not_if { ::File.exists?("/etc/apache2/sites-enabled/#{sitename}.conf") }
      notifies :restart, "service[service_name]"
    end
  end

  template "/var/www/#{sitename}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_title => data["site_title"],
      :comingsoon => "Coming Soon!!"
      )
  end
end

service "service_name" do
  service_name node["apache"]["package"]
	action [:enable, :start]
end

include_recipe "php::default"
