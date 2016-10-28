class profile::lb_member (
  $lb_pool = 'web00',
  $lb_port = '80',
) {

  @@haproxy::balancermember { "haproxy-${::fqdn}":
    listening_service => $lb_pool,
    ports             => $lb_port,
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
    options           => 'check',
  }

}
