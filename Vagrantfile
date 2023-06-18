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
    config.vm.box = "ubuntu2004"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/monitoring.yml"
      ansible.verbose = true
    end
end
