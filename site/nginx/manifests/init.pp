class nginx {

  package { 'nginx':
    ensure => present,
  }
  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'default.conf':
    path   => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  file { 'nginx.conf':
    path   => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['default.conf'], File['nginx.conf'] ],
  }

}
