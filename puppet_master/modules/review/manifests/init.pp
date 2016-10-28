class review (
  String $user = 'review',
) {

  file { '/etc/shells':
    ensure => 'file',
    group  => '0',
    mode   => '0644',
    owner  => '0',
    source => "puppet:///modules/${module_name}/shells",
  }

  file { '/etc/motd':
    ensure  => file,
    content => template("${module_name}/motd.erb"),
  }

  user { $user:
    ensure => present,
    shell  => '/bin/csh',
  }
}
