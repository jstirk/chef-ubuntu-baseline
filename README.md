# ubuntu-baseline Cookbook

Basic security and hardening setup for an Ubuntu machine.

## Requirements

* Be running Ubuntu. Might work on other distros too, but I haven't
  tested it.
  * user
  * openssh
  * sudo
  * ntp
  * simple_iptables
  * swap

## Configuration

### Users

`node.users` should contain an array of all user accounts that will be
created. See https://github.com/fnichol/chef-user for details. Make sure
one of them is in the `sudo` group, otherwise you *will* be locked out
of the machine after first run.

### SMTP

`smtp.smarthost` should be set to the name of an encrypted file in
the `smarthosts` bag.

For example, if the `smtp.smarthost` variable is set to `sendgrid`, the
`smarthosts/sendgrid` hash should look like :

```json
{
  "id": "sendgrid",
  "host": "smtp.sendgrid.net",
  "password": "sekrit",
  "port": 587,
  "username": "myusername"
}
```

These details will be used for all outgoing system mail.

## Usage

Just include `ubuntu-baseline` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ubuntu-baseline]"
  ]
}
```

## License and Authors

Licenced under the MIT licence. See LICENCE.md for more information.
