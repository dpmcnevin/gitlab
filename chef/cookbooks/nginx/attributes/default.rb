default[:nginx][:install_path] = "/usr/local/nginx"
default[:nginx][:version]      = '1.0.9'
default[:nginx][:url]          = "http://nginx.org/download/nginx-#{nginx[:version]}.tar.gz"
default[:nginx][:conf_d]       = "#{nginx[:install_path]}/conf.d"

default[:nginx][:nginx_name]       = "nginx"
default[:nginx][:base_path]        = "/usr/local/nginx"
default[:nginx][:log_path]        = "#{nginx[:base_path]}/logs"
default[:nginx][:pid_path]         = "/var/run"
