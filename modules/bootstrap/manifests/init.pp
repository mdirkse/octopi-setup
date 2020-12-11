class bootstrap {

  ssh_authorized_key { 'octopi-setup':
    ensure => present,
    type   => 'ssh-rsa',
    user   => 'pi',
    key    => String(file('bootstrap/public-key'), '%t'), # Trim any whitespace that may have come along
  }

  # Fix mode for octopi sudo files
  file { ['/etc/sudoers.d/octoprint-service',
          '/etc/sudoers.d/octoprint-shutdown']:
    mode   => '0440',
    before => Sudo::Conf['pi-sudo']
  }

  class { 'sudo':
    purge               => false,
    config_file_replace => false,
  }

  sudo::conf { 'pi-sudo':
    priority => 60,
    content  => 'pi ALL=(ALL) NOPASSWD: ALL',
  }
}
