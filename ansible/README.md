# kosenctfx-infra

Automatically set up challenge server and deploy the challenge for KosenCTFx.

## Preparation

1. Place challenges in `../challenge` directory.
1. Create server instances.
1. Place your SSH private key for servers at `./ssh.key`. The key must be same for all servers.
1. Edit `aws.yml` as following your settings.
1. Edit `./vault-key.sh` as following your environment. Typically, it forms like `echo "${SECRET_KEY}"`.
1. Run `./vault-encrypt.sh`. This script encrypts your files.
1. Edit `ansible.cfg` as following your environment.
1. Edit `username` in `./group_vars/all.yml` as you like.

## How to

Run `./run.bash` to launch ansible script which sets up the server and does deploy the challenge.


## Files

### `hosts`

It should be like the following:

```
[crypto]
192.168.100.11

[pwn]
192.168.100.12

[web1]
192.168.100.13

[web2]
192.168.100.14
```

### `main.yml`

Entrypoint of Ansible. You need to append tasks when you want to open new challenge or you added a new server.

```yaml
- hosts: crypto
  become: no
  remote_user: "{{ username }}"
  tasks:
    - include_role:
        name: challenge
      with_items: [ "crypto/padding_oracle" ] # <-- you should edit this path
      loop_control:
        loop_var: "challenge"
- hosts: pwn
  become: no
  remote_user: "{{ username }}"
  tasks:
    - include_role:
        name: challenge
      with_items: [ "pwn/baby_heap", "pwn/infant_heap" ] # <-- you should edit this path
      loop_control:
        loop_var: "challenge"
# ...
```

### `./roles/user/files/`

Place your SSH public keys here. It is automatically appended to `authorized_keys` for the user. SSH public keys must have its postfix as `.pub`.

### `./roles/iptables/files/ipv4_blocklist`

List the IPv4 addresses to block here. When you want to stop to ban, just remove that address from this file.

This file doesn't support any of IP-range format, comment, ipv6 address, and empty line.

```
192.168.33.100
192.168.33.101
192.168.33.102
...
```

## TODOs

- [ ] Support ipv6 blocklist.
- [ ] Support deploying non-dockerized challenges.
- [ ] Support challenge status check.
- [ ] Add packet capture and back it up to S3.


## Author

theoremoon

## License

MIT
