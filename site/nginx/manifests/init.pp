class nginx {

  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }
  
  file { '/var/www/index.html':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'default.conf':
    ensure => file,
    path   => '/etc/nginx/conf.d/default.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  file { 'nginx.conf':
    ensure => file,
    path   => '/etc/nginx/nginx.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['default.conf'], File['nginx.conf'] ],
  }

}

   
