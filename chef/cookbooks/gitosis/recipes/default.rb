rvm_gem "thin"

package "gitosis"

user "git" do
  comment "Gitosis user"
  system true
  home "/home/git"
  shell "/bin/sh"
end

group "git" do
  members ["git", node[:gitlab][:user]]
end

directory "/home/git" do
  owner "git"
  group "git"
  mode "0750"
  action :create
end

directory "/home/git/.ssh" do
  owner "git"
  group "git"
  mode "0700"
  action :create
end

execute "generate ssh skys for #{node[:gitlab][:user]}." do
  user node[:gitlab][:user]
  creates "/home/#{node[:gitlab][:user]}/.ssh/id_rsa.pub"
  command "ssh-keygen -t rsa -q -f /home/#{node[:gitlab][:user]}/.ssh/id_rsa -P \"\""
end

template "/home/#{node[:gitlab][:user]}/.ssh/config" do
  source "ssh_config.erb"
  owner node[:gitlab][:user]
  group node[:gitlab][:user]
  mode "0600"
end

bash "install gitosis" do
  cwd "/home/git"
  code <<-EOH
    sudo -H -u git gitosis-init < ~#{node[:gitlab][:user]}/.ssh/id_rsa.pub
    sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update
  EOH
  not_if "test -f /home/git/repositories/gitosis-admin.git/hooks/post-update"
end
