SHELL=/bin/bash
#
init_dir: files playbooks docker
files:
	mkdir files
playbooks:
	mkdir playbooks
docker:
	mkdir docker
#
files/id_rsa.pub: files/id_rsa
files/id_rsa: init_dir
	ssh-keygen -b 2048 -t rsa -f files/id_rsa -q -N ""
clean_key:
	rm -f files/id_rsa
	rm -f files/id_rsa.pub
#
vagrant-libvirt:
	sudo gem install vagrant-libvirt
vg-ubuntu2004-box: files/ubuntu2004.box
	vagrant box add --name=ubuntu2004 --provider=libvirt files/ubuntu2004.box
files/ubuntu2004.box:
	wget -O files/ubuntu2004.box https://app.vagrantup.com/generic/boxes/ubuntu2104/versions/4.2.16/providers/libvirt.box
clean_downloads:
	rm files/ubuntu2004.box
	vagrant box remove ubuntu2004
