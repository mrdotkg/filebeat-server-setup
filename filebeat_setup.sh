#!/bin/bash  

# =====================RUNNING THIS SCRIPT==========================
# wget https://github.com/measdot/data/blob/master/filebeat_setup.sh
# sudo chmod +x filebeat_setup.sh
# ./filebeat_setup.sh
#                           _.._..,_,_
#                          (          )
#                           ]~,"-.-~~[
#                         .=])' (;  ([
#                         | ]:: '    [
#                         '=]): .)  ([
#                           |:: '    |
#                            ~~----~~
#                        ~~~~~CHEERS~~~~~
# =====================RUNNING THIS SCRIPT==========================

filebeat_conf="https://raw.githubusercontent.com/measdot/data/master/filebeat_conf/local/filebeat.yml"
if [ $1 = "--prod" ]; then
   filebeat_conf="https://raw.githubusercontent.com/measdot/data/master/filebeat_conf/prod/filebeat.yml"

echo "**** downloading filebeat ****"
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.1-amd64.deb

echo "**** installing filebeat ****"
sudo dpkg -i filebeat-6.2.2-amd64.deb

echo "**** running filebeat ****"
sudo wget -O /etc/filebeat/filebeat.yml $filebeat_conf 
sudo filebeat -e setup --dashboards
sudo service filebeat restart

echo "**** enabling filebeat mysql and apache2 modules ****"
sudo filebeat -e modules enable apache2
sudo filebeat -e modules enable mysql
sudo filebeat setup -e

echo "**** downloading sample mysql and apache2 logs ****"
sudo mkdir /var/log/apache2 /var/log/mysql
sudo wget -O /var/log/apache2/access.log https://raw.githubusercontent.com/measdot/data/master/access.log
sudo wget -O /var/log/apache2/error.log https://raw.githubusercontent.com/measdot/data/master/error.log
sudo wget -O /var/log/mysql/error.log https://raw.githubusercontent.com/measdot/data/master/mysql/error.log
sudo wget -O /var/log/mysql/mysql-slow.log https://raw.githubusercontent.com/measdot/data/master/mysql/mysql-slow.log

echo "**** feeding logs to elk ****"
sudo filebeat -e
