cron { 'puppet':
  command => 'puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1',
  user    => 'root',
  minute  => fqdn_rand(60),
  ensure  => present,
}

# Add Puppet apt repo
apt::source { 'puppet':
  location    => 'http://apt.terrarum.net/ubuntu',
  release     => $::lsbdistcodename,
  repos       => 'main',
  key         => 'F8793AF4',
  key_server  => 'subkeys.pgp.net',
  include_src => false,
}
