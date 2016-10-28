class apache::params {
  case $osfamily {
    'redhat': {
      $package = 'httpd'
      $config  = '/etc/httpd/conf/httpd.conf'
      $service = 'httpd'
    }
    'debian': {
      $package = 'apache2'
      $config  = '/etc/apache2/apache2.conf'
      $service = 'apache2'
    }
  }
}

