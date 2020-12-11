class octopi {
  service{ 'bluetooth':
    ensure => stopped,
    enable => false,
  }
}
