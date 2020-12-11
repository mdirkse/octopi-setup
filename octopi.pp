stage { 'bootstrap': }
Stage['bootstrap'] -> Stage['main']

File { backup => false }
Service { provider => 'systemd' }

class { 'bootstrap': stage => bootstrap }
class { 'octopi': }
