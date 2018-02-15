# -*- mode: ruby -*-
# vi: set ft=ruby :

# Based on the samples of vagrant-docker-compose by Leigh McCulloch, licensed under ISC.
# See https://github.com/leighmcculloch/vagrant-docker-compose/blob/master/example/Vagrantfile
# See also https://medium.com/@cnadeau_/vagrant-as-a-development-environment-e5a83010fb49  

didinstall = false

unless Vagrant.has_plugin?("vagrant-docker-compose")
  system("vagrant plugin install vagrant-docker-compose")
  puts "Installed vagrant-docker-compose"
  didinstall = true
end

unless Vagrant.has_plugin?("vagrant-vbguest")
  system("vagrant plugin install vagrant-vbguest")
  puts "Installed vagrant-vbguest"
  didinstall = true
end

unless Vagrant.has_plugin?("vagrant-disksize")
  system("vagrant plugin install vagrant-disksize")
  puts "Installed vagrant-disksize"
  didinstall = true
end

if didinstall
  puts "Dependencies installed, please try the command again."
  exit
end


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.disksize.size = '15GB'

  config.vm.network(:forwarded_port, guest: 80, host: 80)
  config.vm.network(:forwarded_port, guest: 9980, host: 9980)
  # add additional rsynced share to avoid problems with virtualbox share.
  # Note that this does not sync back to the host.
  config.vm.synced_folder ".", "/app", owner: "www-data", type: "rsync"

  # assuming your source folder is located at the same level as this environment
  # on your host, e.g.
  # myprojects/environment
  #   - this environment
  # myprojects/richdocuments
  #   - your working copy of nextcloud-richdocuments
  if File.directory?(File.expand_path("../richdocuments"))
    config.vm.synced_folder "../richdocuments", "/app-src"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end


  config.vm.provision :shell, inline: "apt-get update"
  config.vm.provision :docker
  config.vm.provision :docker_compose, compose_version:"1.17.0"
end
