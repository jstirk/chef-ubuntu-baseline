#
# Cookbook Name:: committeemanager
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package "vim"
package "git"
package "tmux"

swap_file '/var/swapfile' do
  size node.memory_mb
  persist
end

# provision user accounts
include_recipe 'user::data_bag'

# provisions ssh configured for no password auth and root login
include_recipe 'openssh'

# Make sudo passwordless
include_recipe 'sudo'

# Install NTPd
include_recipe 'ntp'

# Set up iptables. Access to SSH, HTTP, HTTPS only
include_recipe 'simple_iptables'
simple_iptables_policy 'INPUT' do
  policy 'DROP'
end
simple_iptables_rule 'system' do
  rule '-i lo'
  jump 'ACCEPT'
end
simple_iptables_rule 'system' do
  rule '-m conntrack --ctstate ESTABLISHED,RELATED'
  jump 'ACCEPT'
end
simple_iptables_rule 'system' do
  rule '-p icmp'
  jump 'ACCEPT'
end
simple_iptables_rule 'system' do
  rule '-p tcp --dport ssh'
  jump 'ACCEPT'
end
simple_iptables_rule 'http' do
  rule '-p tcp --dport http'
  jump 'ACCEPT'
end
simple_iptables_rule 'https' do
  rule '-p tcp --dport https'
  jump 'ACCEPT'
end

# provisions ssmtp configured for a smarthost defined in a data bag
smarthost = Chef::EncryptedDataBagItem.load(:smarthosts, node.smtp.smarthost)
unless smarthost.nil?
  package 'ssmtp'
  template '/etc/ssmtp/ssmtp.conf' do
    source 'ssmtp.conf.erb'
    owner 'root'
    group 'mail'
    mode '0640'
    variables(
      smarthost: smarthost,
      domain: node.smtp.rewrite_domain,
      admin_email: node.smtp.admin_email,
      hostname: node.server_name
    )
  end
end

# provisions apticron for package update notifications
package 'apticron'
template '/etc/apticron/apticron.conf' do
  source 'apticron.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    email: node.server_admin,
    diff_only: node.apticron.diff_only,
  )
end
