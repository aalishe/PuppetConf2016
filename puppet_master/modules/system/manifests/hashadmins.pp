class system::hashadmins {
  require mysql::server

  $my_defaults = {
    ensure               => present,
    max_queries_per_hour => 600,
  }

  $my_users = {
    'zack@localhost' => {
      max_queries_per_hour => 1200,
    },
    'ralph@localhost' => {
      ensure => absent,
    },
    'monica@localhost' => {},
    'brad@localhost' => {},
    'luke@localhost' => {},
  }

  create_resources( 'mysql_user', $my_users, $my_defaults )

}
