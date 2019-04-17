## Cleanup ovs build with Ansible.

Goal: Remove the dependency on other Git repos by moving the build process for ovs to ansible and checkin the associated patches into a locally maintained subdir under magma/ovs_gtp

In `roles/ovs_gtp`, you can find the main task in order to build the associate patches.

#### Requirement
---

```
ansible <= 2
python
```

#### How to launch a build
---

First of all fill the hosts file, you can either do

- Local build

```[local]
127.0.0.1   ansible_connection=local
```
- Vagrant

```[localvagrant]
127.0.0.1   ansible_ssh_user=vagrant    ansible_ssh_port=2222   ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key
```
- Using a server

```
[my_pool]
Ip_address ansible_port=22 ansible_user=ubuntu
```

When your hostfile is completed, complete the playbook with :

- `hosts: localvagrant`  The host  or pool of hosts you want to build on.
- `ovs_version`			  The ovs version
- `WORK_DIR`				  The Working Directory

To run the playbook just do:

```ansible-playbook ovs_gtp.yml -i hosts```
