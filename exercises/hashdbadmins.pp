class system::hashdbadmins {
  require mysql::server

  $mysql_users_defaults = {
    ensure                => present,
    max_queries_per_hour  => 600,
  }

  $mysql_users = {
    'zack@localhost'    => {
      max_queries_per_hour  => 1200,
    },
    'ralph@localhost'   => {
      ensure                => absent,
    },
    'monica@localhost'  => {},
    'brad@localhost'    => {},
    'luke@localhost'    => {},
  }

  create_resources('mysql_user', $mysql_users, $mysql_users_defaults)
}
