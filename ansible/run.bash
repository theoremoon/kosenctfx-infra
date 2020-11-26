#!/bin/bash
set -ex

ansible-vault decrypt ssh.key.vault --vault-password-file vault-key.sh --output ssh.key
ansible-vault decrypt aws.yml.vault --vault-password-file vault-key.sh --output aws.yml
trap 'rm ssh.key; rm aws.yml' 0 1 2 3 15

export ANSIBLE_BECOME_PASS=some_password_here
ansible-playbook -i hosts main.yml
