#!/bin/bash
set -x

bash ./vault-encrypt.bash decrypt
trap 'rm ssh.key; rm aws.yml' 0 1 2 3 15

export ANSIBLE_BECOME_PASS=some_password_here
if [ -f ssh_config ]; then
    export ANSIBLE_SSH_KEY="~/.vagrant.d/insecure_private_key"
    export ANSIBLE_USER="vagrant"
    ansible-playbook -i hosts main.yml --ssh-common-args "-F ssh_config"
else
    ansible-playbook -i hosts main.yml
fi
