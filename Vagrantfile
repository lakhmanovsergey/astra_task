# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :libvirt do |domain|
    domain.driver = "kvm"
    domain.host = 'localhost'
    domain.uri = 'qemu:///system'
    domain.memory = 1024
    domain.cpus = 1
  end
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu2004"
    ubuntu.vm.synced_folder "./docker/", "/home/vagrant/docker", type: "rsync"
    ubuntu.vm.network "forwarded_port", guest: 3000, host: 3000, protocol: "tcp"
    ubuntu.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/monitoring.yml"
      ansible.verbose = true
    end
  end
end
