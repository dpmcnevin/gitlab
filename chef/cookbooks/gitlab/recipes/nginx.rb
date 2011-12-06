template "#{node[:nginx][:conf_d]}/gitlab.conf" do
  source "nginx.gitlab.conf.erb"
  variables(
    :base_port => node[:gitlab][:base_port],
    :server_count => node[:gitlab][:server_count],
    :hostname => node[:gitlab][:hostname]
  )
  action :create
end
