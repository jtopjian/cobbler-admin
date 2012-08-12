#!/bin/bash
apt-get update
apt-get install -y puppet git rubygems
cd /root
git clone https://github.com/jtopjian/openstack-stuff
git clone https://github.com/jtopjian/puppetlabs-nova jtopjian-nova
cp -a openstack-stuff/puppet/manifests/* /etc/puppet/manifests/
cp -a openstack-stuff/puppet/modules/* /etc/puppet/modules/
cd /etc/puppet/modules
git clone https://github.com/jtopjian/puppetlabs-puppet puppet
git clone https://github.com/puppetlabs/puppetlabs-mysql mysql
git clone https://github.com/puppetlabs/puppetlabs-concat concat
git clone https://github.com/puppetlabs/puppetlabs-stdlib stdlib
git clone https://github.com/puppetlabs/puppetlabs-glance glance
git clone https://github.com/puppetlabs/puppetlabs-nova nova
cp -a /root/jtopjian-nova/manifests/volume* nova/manifests/
git clone https://github.com/puppetlabs/puppetlabs-keystone keystone
git clone https://github.com/puppetlabs/puppetlabs-keystone keystone
git clone https://github.com/puppetlabs/puppetlabs-horizon horizon
git clone https://github.com/puppetlabs/puppetlabs-rabbitmq rabbitmq
git clone https://github.com/benwhatever/puppet-htpasswd htpasswd
git clone https://github.com/saz/puppet-memcached memcached
git clone https://github.com/puppetlabs/puppetlabs-ntp ntp
wget http://forge.puppetlabs.com/system/releases/p/puppetlabs/puppetlabs-ruby-0.0.1.tar.gz
tar xzvf puppetlabs-ruby-0.0.1.tar.gz
mv puppetlabs-ruby-0.0.1 ruby
rm puppetlabs-ruby-0.0.1.tar.gz
