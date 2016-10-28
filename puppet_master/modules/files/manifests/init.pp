class files {
  
  file_line { 'allow root':
    ensure => present,
    path   => '/etc/cron.allow',
    line   => 'root',
  }

  file_line { 'deny all':
    ensure => present,
    path   => '/etc/cron.deny',
    line   => '*',
  }

  file { [
    '/etc/cron.allow',
    '/etc/cron.deny',
  ]:
    ensure => file,
  }

  concat_file { '/etc/motd':
    ensure => present,
    tag    => 'workdamnit',
  }

  Concat_fragment {
    target => '/etc/motd',
    tag    => 'workdamnit',
  }

  concat_fragment { 'stuff':
    order   => '01',
    content => '#THIS IS A HEADER',
  }

  concat_fragment { 'other stuff':
    order   => '100',
    content => inline_template('<%= @hostname %>'),
  }

}
