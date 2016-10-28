class kerberos {

  augeas { 'do something':
    context => '/files/etc/krb5.conf/libdefaults',
    changes => 'set default_realm PUPPETLABS.VM',
  }

}
