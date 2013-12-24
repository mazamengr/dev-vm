class site {
    file { '/etc/apt/sources.list.d':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root';
    }
    file { '/etc/apt/sources.list.d/dotdeb.list':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => "deb http://packages.dotdeb.org squeeze all\ndeb-src http://packages.dotdeb.org squeeze all\ndeb http://packages.dotdeb.org squeeze-php54 all\ndeb-src http://packages.dotdeb.org squeeze-php54 all";
    }
    exec { 'dotdeb-key':
        path    => '/bin:/usr/bin',
        cwd     => '/tmp',
        command => "wget -O - http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -",
        require => File['/etc/apt/sources.list.d/dotdeb.list'],
        notify  => Exec["update-apt"];
    }
    exec {'update-apt':
        path    => '/bin:/usr/bin',
        command => 'apt-get update',
        require => Exec['dotdeb-key'],
        refreshonly => true;
    }
    package {'curl':
        ensure  => 'installed'
    }
    package {
        'apache2-mpm-worker':
            ensure  => installed,
            require => Exec['update-apt'];

        ['php5-fpm', 'libapache2-mod-fastcgi']:
            ensure  => installed,
            require => Package['apache2-mpm-worker'],
            notify  => Exec['upgrade-apache'];

        'php5-cli':
            ensure  => installed,
            require => Package['php5-fpm'];

        ["php5-xdebug", "php5-tidy", "php5-sqlite", "php5-redis", "php5-pgsql", "php5-mysqlnd", "php5-memcache", "phphp5-memcached", "php5-mcrypt", "php5-imagick", "php5-http", "php5-gmp", "php5-gd", "php5-curl", "php5-apc", "php5-intl", "php5-igbinary", "php5-mongo", "php5-oauth", "php5-runkit", "php5-stats", "php5-stomp", "php5-ydf", "php5-yaml"]:
            ensure  => installed,
            require => Package['php5-fpm'];
    }

    exec {'upgrade-apache':
        path    => '/bin;/usr/bin;/usr/sbin',
        command => '/usr/sbin/a2enmod actions; /usr/sbin/a2enmod rewrite; /usr/sbin/service apache2 restart',
        require => Package['libapache2-mod-fastcgi', 'apache2-mpm-worker'];
    }
    package {'vim':
        ensure  => installed,
        require => Exec['update-apt'];
    }
    package {'git':
        ensure  => installed,
        require => Exec['update-apt'];
    }
    package { 'mysql-server-5.5':
        ensure  => installed,
        require => Exec['update-apt'];
    }
    exec {'install-composer':
        path    => '/bin;/usr/bin',
        command => '/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php && /bin/mv composer.phar /usr/local/bin/composer',
        require => Package['curl', 'php5-cli'];
    }
}

include site
