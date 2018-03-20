#!/bin/bash  

echo "**** downloading filebeat ****"
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-amd64.deb

echo "**** installing filebeat ****"
sudo dpkg -i filebeat-6.2.2-amd64.deb

echo "**** running filebeat ****"
sudo wget -O /etc/filebeat/filebeat.yml https://raw.githubusercontent.com/measdot/data/master/filebeat.yml 
sudo filebeat -e setup --dashboards
sudo service filebeat restart

echo "**** enabling filebeat mysql and apache2 modules ****"
sudo filebeat -e modules enable apache2
sudo filebeat -e modules enable mysql
sudo filebeat setup -e

echo "**** downloading sample mysql and apache2 logs ****"
sudo mkdir /var/log/apache2
sudo mkdir /var/log/mysql
sudo wget -O /var/log/apache2/access.log https://raw.githubusercontent.com/measdot/data/master/access.log
sudo wget -O /var/log/apache2/error.log https://raw.githubusercontent.com/measdot/data/master/error.log
sudo wget -O /var/log/mysql/error.log https://raw.githubusercontent.com/measdot/data/master/mysql/error.log
sudo wget -O /var/log/mysql/error.log https://raw.githubusercontent.com/measdot/data/master/mysql/mysql-slow.log

echo "**** feeding logs to elk ****"
sudo filebeat -e
