ansible-ssh-config
====================================

[![Build Status](https://travis-ci.org/FGtatsuro/ansible-ssh-config.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-ssh-config)

Ansible role for ssh configuration.

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- Alpine Linux
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

|name|description|type|default|
|---|---|---|---|
|sshconfig_home|`.ssh` directory is put under the directory of this value.|str|/root|
|sshconfig_owner|User of `.ssh` directory. `ssh_home` should also be home directory of this user.|str|root|
|sshconfig_group|Group of `.ssh` directory.|str|root(This value is only valid on Linux. For OSX, please use `wheel` or `admin` as same means.)|
|sshconfig_knownhosts|Hosts included in `.ssh/known_hosts`.|list|Empty list. No host is added in known_hosts in default.|
|sshconfig_publickey_paths|Paths of public keys on local. They are copied under `.ssh` directory on remote.<br>Each basename are used as each key name. For example, when `./resources/ssh/id_rsa2.pub` exists in `sshconfig_publickey_paths`, `id_rsa2.pub` is copied under `.ssh` directory.|list|Empty list. No public key is added under `.ssh` directory.|
|sshconfig_privatekey_paths|Paths of private keys on local. They are copied under `.ssh` directory on remote.<br>Each basename are used as each key name. For example, when `./resources/ssh/id_rsa2` exists in `sshconfig_privatekey_paths`, `id_rsa2` is copied under `.ssh` directory.|list|Empty list. No public key is added under `.ssh` directory.|
|sshconfig_authorizedkey_paths|Paths of authorized keys on local. They are added in `.ssh/authorized_keys` file on remote.|list|Empty list. No authorized key is added in `.ssh/authorized_keys` file.|
|sshconfig_clientconfig_path|Path of SSH client config on local. It is copied as `.ssh/config` file on remote.|str|It isn't defined in default.|

- If dest paths of public keys/private keys already exist, playbook execution will be failed.
- Basenames of `sshconfig_publickey_paths`/`sshconfig_privatekey_paths` are used as each key name. For example, when `./resources/ssh/id_rsa2.pub` exists in `sshconfig_publickey_paths`, `id_rsa2.pub` is copied under `.ssh` directory.

Role Dependencies
-----------------

The dependencies on other roles for this role.

- FGtatsuro.ssh-client

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: FGtatsuro.ssh_config }

Test on local Docker host
-------------------------

This project run tests on Travis CI, but we can also run them on local Docker host.
Please check `install`, `before_script`, and `script` sections of `.travis.yml`.
We can use same steps of them for local Docker host.

Local requirements are as follows.

- Ansible (>= 2.0.0)
- Docker (>= 1.10.1)

License
-------

MIT
