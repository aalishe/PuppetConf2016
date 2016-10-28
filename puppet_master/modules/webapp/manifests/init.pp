class webapp {

  include apache
  include apache::mod::php
  include mysql::server

  class { 'mysql::bindings':
    php_enable => true,
  }

  apache::vhost { $fqdn:
    vhost_name => $fqdn,
    port       => 80,
    docroot    => '/var/www/html',
  }
}
