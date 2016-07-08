#! /bin/bash
sudo apt-get install apache2 mysql-server php7.0-mysql php7.0 libapache2-mod-php7.0 php7.0-mcrypt phpmyadmin apache2-utils
sudo sed -i '$a\# phpMyAdmin Configuration' /etc/apache2/apache2.conf
sudo sed -i 'Include /etc/phpmyadmin/apache.conf' /etc/apache2/apache2.conf
