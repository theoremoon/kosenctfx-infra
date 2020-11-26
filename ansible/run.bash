#!/bin/bash
set -ex

bash ./vault-encrypt.bash decrypt
trap 'rm ssh.key; rm aws.yml' 0 1 2 3 15

export ANSIBLE_BECOME_PASS=some_password_here
ansible-playbook -i hosts main.yml
