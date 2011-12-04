execute "update apt" do
  command "apt-get update"
end

packages = %w{
  git-core 
  curl 
  gcc 
  g++
  libxml2-dev 
  libxslt1-dev 
  sqlite3 
  libsqlite3-dev 
  libcurl4-openssl-dev 
  libreadline5-dev 
  libc6-dev 
  libssl-dev 
  libmysql++-dev 
  make 
  build-essential 
  zlib1g-dev 
  python-setuptools
  python-dev
  ack-grep

  htop
  lsof
  tree
}

packages.each do |pkg|
  package pkg
end
