package "gitosis"

user "git" do
  comment "Gitosis user"
  system true
  home "/home/git"
  shell "/bin/sh"
end

group "git" do
  members ["git", "vagrant"]
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

username = "vagrant"
execute "generate ssh skys for #{username}." do
  user username
  creates "/home/#{username}/.ssh/id_rsa.pub"
  command "ssh-keygen -t rsa -q -f /home/#{username}/.ssh/id_rsa -P \"\""
end

bash "install gitosis" do
  cwd "/home/git"
  code <<-EOH
    sudo -H -u git gitosis-init < ~#{username}/.ssh/id_rsa.pub
    sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update
  EOH
  not_if "test -f /home/git/repositories/gitosis-admin.git/hooks/post-update"
end
