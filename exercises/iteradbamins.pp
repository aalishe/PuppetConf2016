class system::iteradbadmins {
  require mysql::server

  $mysql_users = {
    'zack'    => {
      max_queries_per_hour  => 1200,
    },
    'ralph'   => {
      ensure                => absent,
    },
    'monica'  => {},
    'brad'    => {},
    'luke'    => {},
  }

  Mysql_user {
    ensure               => present,
    max_queries_per_hour => 600,
  }

  User {
    ensure => present
  }

  $mysql_users.each |String $username, Hash $attributes| {
    mysql_user {"$username@localhost":
      * => $attributes,
      # ensure               => $attributes['ensure'],
      # max_queries_per_hour => $attributes['max_queries_per_hour'],
    }
    user {"$username":
      * => $attributes,
      # ensure => $attributes['ensure'],
    }
  }
}
