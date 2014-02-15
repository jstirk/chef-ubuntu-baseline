name             'ubuntu-baseline'
maintainer       'Achernar Solutions'
maintainer_email 'jason@achernarsolutions.com.au'
license          'All rights reserved'
description      'Basic setup and security hardening for an Ubuntu server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'user', '~> 0.3.0'
depends 'openssh', '~> 1.1.4'
depends 'sudo'
depends 'ntp'
depends 'simple_iptables', '~> 0.2.4'
depends 'swap', '~> 0.3.6'
