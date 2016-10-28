class ordering {
  include ordering::epel
  include ordering::mysql
  notify { 'This is after MySQL':
    require => Class['ordering::mysql'],
  }
}
