template "#{node[:nginx][:conf_d]}/gitlab.conf" do
  source "nginx.gitlab.conf.erb"
  variables(
    :base_port => 3000,
    :server_count => 1,
    :hostname => node[:gitlab][:hostname]
  )
  action :create
  notifies :restart, "service[nginx]"
end
