setup: vagrant-up setup-ansible

vagrant-up:
	(cd vagrant; vagrant up)
	(cd vagrant; vagrant ssh-config > ../ansible/ssh_config)

setup-ansible:
	cp ~/.vagrant.d/insecure_private_key ./ansible/ssh.key
	(cd ansible; bash vault-encrypt.bash)

down:
	(cd vagrant; vagrant destroy -f)
	rm ansible/ssh_config
