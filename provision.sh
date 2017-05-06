#!/usr/bin/env bash

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.klaus-uwe.me/mariadb/repo/10.1/ubuntu xenial main'

apt-get update
apt-get upgrade -y

apt-get -qq install -y git gettext curl vim ccze software-properties-common zip unzip rar unrar wget imagemagick ant ant-contrib crudini

debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'
apt-get -q install -y mariadb-server
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
mysql -u root -proot --execute="CREATE DATABASE \`development\` CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'"
mysql -u root -proot --execute="UPDATE \`mysql\`.\`user\` SET \`Host\`='%' WHERE \`Host\`='::1' AND \`User\`='root'"
/etc/init.d/mysql restart

apt-get -qq install -y apache2 apache2-utils libapache2-mod-xsendfile
a2enmod rewrite
a2enmod env
a2enmod headers
a2enmod alias
a2dismod status
a2dissite 000-default.conf

apt-get -qq install -y php7.0 php7.0-dev php-pear libapache2-mod-php7.0 php7.0-mysql php7.0-sqlite3 php7.0-imap php7.0-ldap php7.0-curl php7.0-soap php7.0-xml php7.0-gd php7.0-intl php7.0-gettext php7.0-bcmath php7.0-zip php7.0-bz2 php7.0-mcrypt php7.0-mbstring php-apcu php-imagick
pecl install apcu_bc-beta
for SEGMENT in apache2 cli
do
    CFG="/etc/php/7.0/${SEGMENT}/php.ini"
    crudini --set ${CFG} PHP expose_php Off
    crudini --set ${CFG} PHP default_charset "UTF-8"
    crudini --set ${CFG} PHP memory_limit 1024M
    crudini --set ${CFG} PHP post_max_size 32M
    crudini --set ${CFG} PHP log_errors On
    crudini --set ${CFG} PHP display_errors On
    crudini --set ${CFG} PHP display_startup_errors On
    crudini --set ${CFG} PHP mail.add_x_header Off
    crudini --set ${CFG} PHP error_log /var/www/development/log/php_error.log
    crudini --set ${CFG} PHP mail.log /var/www/development/log/mail_error.log
    crudini --set ${CFG} PHP sys_temp_dir /var/www/development/temp
    crudini --set ${CFG} PHP upload_tmp_dir /var/www/development/temp
    crudini --set ${CFG} Date date.timezone Europe/Zurich
    crudini --set ${CFG} opcache opcache.enable On
    crudini --set ${CFG} opcache opcache.enable_cli On
    crudini --set ${CFG} opcache opcache.error_log /var/www/development/log/opcache_error.log
    crudini --set ${CFG} Phar phar.readonly Off
    crudini --set ${CFG} Session session.cookie_httponly On
    crudini --set ${CFG} Session session.name xsid
    if [ "${SEGMENT}" = "cli" ]; then
        crudini --set ${CFG} PHP max_execution_time 0
    else
        crudini --set ${CFG} PHP max_execution_time 300
    fi
done
echo "extension=apc.so" >> /etc/php/7.0/mods-available/apcu.ini
crudini --set /etc/php/7.0/mods-available/apcu.ini "" apc.enable On
crudini --set /etc/php/7.0/mods-available/apcu.ini "" apc.enable_cli On

ln -s /var/www/development/virtualhost.conf /etc/apache2/sites-enabled/develop.conf
sed -i 's/www-data/ubuntu/g' /etc/apache2/envvars
/etc/init.d/apache2 restart
cp /var/www/development/logrotate /etc/logrotate.d/devbox

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

wget http://www.phing.info/get/phing-latest.phar
chmod +x phing-latest.phar
mv phing-latest.phar /usr/local/bin/phing

curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get -qq install -y nodejs

echo ""
echo "---------------------------------------------------------"
echo "http://localhost:8080"
echo "---------------------------------------------------------"
echo ""