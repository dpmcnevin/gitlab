#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2011, Gobbler
#
# All rights reserved - Do Not Redistribute
#

packages = value_for_platform(
    ["centos","redhat","fedora"] => {'default' => ['pcre-devel', 'openssl-devel']},
    "default" => ['libpcre3', 'libpcre3-dev', 'libssl-dev']
  )

packages.each do |devpkg|
  package devpkg
end

tar_file = "nginx-#{node[:nginx][:version]}.tar.gz"

remote_file "/tmp/#{tar_file}" do
  source "#{node[:nginx][:url]}"
  not_if { ::File.exists?("/tmp/#{tar_file}") }
end

bash "Install Nginx" do
  cwd "/tmp"
  code <<-EOH
    tar zxf #{tar_file}
    cd nginx-#{node[:nginx][:version]}
    ./configure --prefix=#{node[:nginx][:install_path]}
    make install
  EOH
  not_if do
    ::File.exists?("#{node[:nginx][:install_path]}/sbin/nginx") &&
    system("#{node[:nginx][:install_path]}/sbin/nginx -v 2>&1 | grep -q '#{node[:nginx][:version]}$'")
  end
end

base_path = node[:nginx][:base_path]

directory node[:nginx][:log_path] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

directory node[:nginx][:conf_d] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/init/nginx.conf" do
  source "upstart.nginx.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  variables(
    :path => node[:nginx][:install_path],
    :pid_path => node[:nginx][:pid_path]
  )
  action :create
end

template "#{node[:nginx][:install_path]}/conf/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :log_path => node[:nginx][:log_path],
    :pid_path => node[:nginx][:pid_path],
    :conf_d   => node[:nginx][:conf_d]
  )
  action :create
  notifies :restart, "service[nginx]"
end

service "nginx" do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :restart => true, :stop => true
  action [:enable, :start]
end
