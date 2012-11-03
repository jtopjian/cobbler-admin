cron { 'puppet':
  command => 'puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1',
  user    => 'root',
  minute  => fqdn_rand(60),
  ensure  => present,
}
