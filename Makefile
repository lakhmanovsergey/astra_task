SHELL=/bin/bash
VMHOST=ubuntu
VMBOX=ubuntu2004
BOX_URL=https://app.vagrantup.com/generic/boxes/ubuntu2004/versions/4.2.16/providers/libvirt.box
#
default: init_dir git_pull vg-ubuntu-box vagrant_ansible
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
vg-ubuntu-box: files/$(VMBOX).box vagrant-libvirt
	vagrant box add --force --name=$(VMBOX) provider=libvirt files/$(VMBOX).box
files/$(VMBOX).box:
	wget -O files/$(VMBOX).box $(BOX_URL)
clean_downloads:
	rm files/$(VMBOX).box
	vagrant box remove $(VMBOX)
#
vagrant_start:
	vagrant status | grep -q $(VMHOST) || \
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
	git commit --message "change `date`"
	git push -u origin main
git_pull:
	git pull
