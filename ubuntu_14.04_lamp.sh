#! /bin/bash
sudo apt-get install apache2 mysql-server libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5 php5-mcrypt phpmyadmin apache2-utils
sudo sed -i '$a\# phpMyAdmin Configuration' /etc/apache2/apache2.conf
sudo sed -i 'Include /etc/phpmyadmin/apache.conf' /etc/apache2/apache2.conf
