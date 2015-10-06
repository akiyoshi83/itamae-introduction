# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  config.vm.define "app", primary: true do |mm|
    mm.vm.provider "virtualbox" do |vb|
      vb.name = "app"
    end
    mm.vm.hostname = "app.example.com"
    mm.vm.network "private_network", ip: "172.30.1.10"
  end

  config.vm.define "db" do |mm|
    mm.vm.provider "virtualbox" do |vb|
      vb.name = "db"
    end
    mm.vm.hostname = "db.example.com"
    mm.vm.network "private_network", ip: "172.30.1.20"
  end
end
