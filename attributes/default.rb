default.packages = %w(vim git tmux)
default.whitelist_hosts = []

default.user.ssh_keygen = false

default.authorization.sudo.groups = [ 'admin', 'sysadmin', 'sudo' ]
default.authorization.sudo.include_sudoers_d = true
default.authorization.sudo.passwordless = true

# defines sshd configuration that differ from /etc/ssh/sshd_config defaults
default.openssh.server.permit_root_login = 'no'
default.openssh.server.password_authentication = 'no'
default.openssh.server.login_grace_time = '30'
default.openssh.server.use_p_a_m = 'no'
default.openssh.server.print_motd = 'no'

default.smtp.provider = 'ssmtp'
default.smtp.smarthost = 'sendgrid'
default.smtp.rewrite_domain = node.server_name
default.smtp.admin_email = node.server_admin

default.apticron.diff_only = false

default.ntp.servers = [ '0.oceania.pool.ntp.org',
                        '1.oceania.pool.ntp.org',
                        '2.oceania.pool.ntp.org',
                        '3.oceania.pool.ntp.org',
                        '0.north-america.pool.ntp.org',
                        '1.north-america.pool.ntp.org'
                      ]
