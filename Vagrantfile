# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
apt-get update -y
apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring
apt-get install -y git-core
apt-get install -y ruby1.9.3
curl -s https://get.docker.io/ubuntu/ | sudo sh
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "base"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "192.168.33.10"
  #config.vm.network :public_network
  config.vm.synced_folder "./", "/dockerfiles"
  config.vm.provision "shell", inline: $script
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
end