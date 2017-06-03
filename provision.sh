#!/usr/bin/env bash

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.klaus-uwe.me/mariadb/repo/10.1/ubuntu xenial main'

apt-get update
apt-get upgrade -y

apt-get install -y git gettext curl vim ccze software-properties-common zip unzip rar unrar wget imagemagick \
                       ant ant-contrib crudini

debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'
apt-get install -y mariadb-server

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
mysql -u root -proot --execute="CREATE DATABASE \`development\` CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'"
mysql -u root -proot --execute="UPDATE \`mysql\`.\`user\` SET \`Host\`='%' WHERE \`Host\`='::1' AND \`User\`='root'"
/etc/init.d/mysql restart

apt-get -qq install -y apache2 apache2-utils libapache2-mod-xsendfile
a2enmod rewrite
a2enmod env
a2enmod headers
a2enmod alias
a2enmod ssl
a2dismod status
a2dissite 000-default.conf

apt-get install -y php7.0 php7.0-dev php-pear libapache2-mod-php7.0 php7.0-mysql php7.0-sqlite3 php7.0-imap \
                       php7.0-ldap php7.0-curl php7.0-soap php7.0-xml php7.0-gd php7.0-intl php7.0-gettext \
                       php7.0-bcmath php7.0-zip php7.0-bz2 php7.0-mcrypt php7.0-mbstring php-apcu php-imagick

pecl install apcu_bc-beta

echo "extension=apc.so" >> /etc/php/7.0/mods-available/apcu.ini
crudini --set /etc/php/7.0/mods-available/apcu.ini "" apc.enable On
crudini --set /etc/php/7.0/mods-available/apcu.ini "" apc.enable_cli On
crudini --set /etc/php/7.0/cli/php.ini Phar phar.readonly Off

(cd /var/www/development/configs && ./create_certs.sh)
sed -i 's/www-data/ubuntu/g' /etc/apache2/envvars
ln -s /var/www/development/configs/virtualhost.conf /etc/apache2/sites-enabled/develop.conf
/etc/init.d/apache2 restart
cp /var/www/development/configs/logrotate /etc/logrotate.d/devbox

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

wget http://www.phing.info/get/phing-latest.phar
chmod +x phing-latest.phar
mv phing-latest.phar /usr/local/bin/phing

curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get -qq install -y nodejs
