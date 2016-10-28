class system::hosts_static {
  resources { 'host':
    purge => true,
  }
  host { 'localhost':
    ensure       => 'present',
    host_aliases => ['localhost.localdomain', 'localhost6', 'localhost6.localdomain6'],
    ip           => '::1',
    target       => '/etc/hosts',
  }
  host { 'master.puppetlabs.vm':
    ensure       => 'present',
    host_aliases => ['master'],
    ip           => '10.0.1.4',
    target       => '/etc/hosts',
  }
  host { 'ranjit.puppetlabs.vm':
    ensure       => 'present',
    host_aliases => ['ranjit'],
    ip           => '172.16.218.178',
    target       => '/etc/hosts',
  }
  host { 'student.puppetlabs.vm':
    ensure       => 'present',
    host_aliases => ['student', 'localhost', 'localhost.localdomain', 'localhost4'],
    ip           => '127.0.0.1',
    target       => '/etc/hosts',
  }
}
