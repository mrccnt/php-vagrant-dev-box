# PHP Vagrant Developer Box

Goal of this little project was to have a full Ubuntu 16.04 / PHP 7.0 based LAMP stack. In fact it is a pretty good
installation guide on how to set up all those things.

    VBox Name:  PHP Developer Box
    Base Box:   ubuntu/xenial64 (Official Ubuntu)
    Hostname:   development.dev
    RAM:        2048 MB
    CPUs:       2
    
## PHP 7.0

    $ php -v
    PHP 7.0.15-0ubuntu0.16.04.4 (cli) ( NTS )
    Copyright (c) 1997-2017 The PHP Group
    Zend Engine v3.0.0, Copyright (c) 1998-2017 Zend Technologies
        with Zend OPcache v7.0.15-0ubuntu0.16.04.4, Copyright (c) 1999-2017, by Zend Technologies

Along with the default modules, some  extra modules including php-imagick, apcu and apcu_bc are available:

    $ php -m
    [PHP Modules]
    apc
    apcu
    bcmath
    bz2
    calendar
    Core
    ctype
    curl
    date
    dom
    exif
    fileinfo
    filter
    ftp
    gd
    gettext
    hash
    iconv
    imagick
    imap
    intl
    json
    ldap
    libxml
    mbstring
    mcrypt
    mysqli
    mysqlnd
    openssl
    pcntl
    pcre
    PDO
    pdo_mysql
    pdo_sqlite
    Phar
    posix
    readline
    Reflection
    session
    shmop
    SimpleXML
    soap
    sockets
    SPL
    sqlite3
    standard
    sysvmsg
    sysvsem
    sysvshm
    tokenizer
    wddx
    xml
    xmlreader
    xmlwriter
    xsl
    Zend OPcache
    zip
    zlib
    
    [Zend Modules]
    Zend OPcache

## Apache 2.4

    $ apache2 -v
    Server version: Apache/2.4.18 (Ubuntu)
    Server built:   2016-07-14T12:32:26

The following modules are enabled:

    access_compat.load -> ../mods-available/access_compat.load
    alias.conf -> ../mods-available/alias.conf
    alias.load -> ../mods-available/alias.load
    auth_basic.load -> ../mods-available/auth_basic.load
    authn_core.load -> ../mods-available/authn_core.load
    authn_file.load -> ../mods-available/authn_file.load
    authz_core.load -> ../mods-available/authz_core.load
    authz_host.load -> ../mods-available/authz_host.load
    authz_user.load -> ../mods-available/authz_user.load
    autoindex.conf -> ../mods-available/autoindex.conf
    autoindex.load -> ../mods-available/autoindex.load
    deflate.conf -> ../mods-available/deflate.conf
    deflate.load -> ../mods-available/deflate.load
    dir.conf -> ../mods-available/dir.conf
    dir.load -> ../mods-available/dir.load
    env.load -> ../mods-available/env.load
    filter.load -> ../mods-available/filter.load
    headers.load -> ../mods-available/headers.load
    mime.conf -> ../mods-available/mime.conf
    mime.load -> ../mods-available/mime.load
    mpm_prefork.conf -> ../mods-available/mpm_prefork.conf
    mpm_prefork.load -> ../mods-available/mpm_prefork.load
    negotiation.conf -> ../mods-available/negotiation.conf
    negotiation.load -> ../mods-available/negotiation.load
    php7.0.conf -> ../mods-available/php7.0.conf
    php7.0.load -> ../mods-available/php7.0.load
    rewrite.load -> ../mods-available/rewrite.load
    setenvif.conf -> ../mods-available/setenvif.conf
    setenvif.load -> ../mods-available/setenvif.load
    xsendfile.load -> ../mods-available/xsendfile.load

## MariaDB 10.1

    $ mysql --version
    mysql  Ver 15.1 Distrib 10.1.22-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2

Credentials:

    username: root
    password: root
    database: development

The database is set up to listen on public network which means we can reach the database directly without additional ssh tunnels.

## Dev Tools

 + Node.js 7
 + Grunt CLI (global)
 + Composer (global)
 + Phing (global)
 + Git
 + Ant
 + Ant-Contrib
 
## Additional Packages

 + gettext
 + curl
 + vim
 + ccze
 + zip
 + unzip
 + wget
 + imagemagick
 + crudini
 + software-properties-common

## Directory Structure

    TODO: ...

## Log Rotation

    TODO: ...

## Known Bug

When encountering problems connecting to the box in any other way than `vagrant ssh`, check this known bug:

[Enable default SSH login](https://bugs.launchpad.net/cloud-images/+bug/1569237)

    vagrant ssh
    sudo passwd -d -u ubuntu
    sudo chage -d0 ubuntu
    exit
    vagrant ssh
    (You will be promped for a new password and get disconnected)
    (Done)