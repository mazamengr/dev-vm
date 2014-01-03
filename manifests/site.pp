class site {
    exec {'update-apt':
        path    => '/bin:/usr/bin',
        command => 'apt-get update',
    }
    package {'curl':
        ensure  => 'installed',
        require => Exec['update-apt'];
    }
    package {'apache2':
        ensure  => 'installed',
        require => Exec['update-apt'];
    }
    package {
        ['apache2-mpm-worker', 'libapache2-mod-fcgid']:
        ensure  => 'installed',
        require => Package['apache2'];
    }
    package {
        ['mysql-server-core-5.5', 'mysql-server-5.5']:
        ensure  => installed,
        require => Exec['update-apt'];
    }
    package {'vim':
        ensure  => installed,
        require => Exec['update-apt'];
    }
    package {'git':
        ensure  => installed,
        require => Exec['update-apt'];
    }
    package {
        ['php5', 'php5-cli', 'php5-xdebug', 'php5-tidy', 'php5-sqlite', 'php5-memcache', 'php5-memcached', 'php5-mcrypt', 'php5-mysql', 'php5-mysqlnd', 'php5-imagick', 'php5-gmp', 'php5-gd', 'php5-curl', 'php5-intl']:
            ensure  => 'installed',
            require => Package['apache2'];
    }
    package {'libapache2-mod-php5':
        ensure  => 'installed',
        require => Package['php5', 'apache2'];
    }
    exec {'enable-mod_rewrite':
        path    => '/usr/sbin',
        command => 'a2enmod rewrite',
        require => Package['apache2'];
    }
    exec {'restart-apache':
        path    => '/bin:/usr/bin',
        command => 'service apache2 restart',
        require => Exec['enable-mod_rewrite'];
    }
    exec {'install-composer':
        path    => '/bin:/usr/bin',
        command => 'curl -sS https://getcomposer.org/installer | php && /bin/mv composer.phar /usr/local/bin/composer',
        require => Package['curl', 'php5-cli'];
    }
}

include site
