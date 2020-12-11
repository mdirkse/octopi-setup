class octopi {
  service{ ['avahi-daemon', 'alsa-restore', 'alsa-state','bluetooth']:
    ensure => stopped,
    enable => false,
  }

  file { '/etc/ssh/sshd_config':
    ensure => 'file',
    owner  => 0,
    group  => 0,
    mode   => '0644',
    source => 'puppet:///modules/octopi/sshd_config',
    notify => Service['ssh'],
  }

  service{ 'ssh':
    ensure => running,
    enable => true,
  }
}
