# Gitlab w/ Chef & Vagrant

Get the 'Lucid 32' box (it should work on others, but only tested with
it)

    vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

Clone repository

    git clone git://github.com/dpmcnevin/gitlab.git

Init and update the submodules

    git submodule init
    git submodule update

Start up vagrant
  
    vagrant up
