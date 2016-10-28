class system::hashadmins {
  require mysql::server

  Mysql_user {
    ensure               => present,
    max_queries_per_hour => 600,
  }

  $my_users = {
    'zack' => {
      max_queries_per_hour => 1200,
    },
    'ralph' => {
      ensure => absent,
    },
    'monica' => {},
    'brad' => {},
    'luke' => {},
  }

  $my_users.each | String $user, Hash $params | {
    mysql_user { "${user}@localhost":
      * => $params,
    }
  }

}
