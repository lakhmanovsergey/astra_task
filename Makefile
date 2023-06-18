SHELL=/bin/bash
VMHOST="ubuntu"
VMBOX="ubuntu2020"
BOX_URL="https://app.vagrantup.com/generic/boxes/ubuntu2104/versions/4.2.16/providers/libvirt.box"
#
init_dir: files playbooks docker
files:
	mkdir files
playbooks:
	mkdir playbooks
docker:
	mkdir docker
#
vagrant-libvirt:
	sudo gem install vagrant-libvirt
vg-ubuntu2004-box: files/ubuntu2004.box
	vagrant box add --name=$(VMBOX) provider=libvirt files/$(VMBOX).box
files/ubuntu2004.box:
	wget -O files/$(VMBOX).box $(BOX_URL)
clean_downloads:
	rm files/$(VMBOX).box
	vagrant box remove $(VMBOX)
#
vagrant_start:
	vagrant up
vagrant_ansible: vagrant_start
	vagrant provision
vagrant_destroy:
	vagrant destroy
#
git_add:
	git add \
		.gitignore \
		Vagrantfile \
		Makefile \
		playbooks/monitoring.yml \
		docker/
git_commit: git_add
	git commit --message "change"
