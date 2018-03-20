#install
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-amd64.deb
sudo dpkg -i filebeat-6.2.2-amd64.deb

#run
sudo wget -O /etc/filebeat/filebeat.yml https://raw.githubusercontent.com/measdot/data/master/filebeat.yml 
sudo filebeat -e setup --dashboards
sudo service filebeat restart

#enable
sudo filebeat -e modules enable apache2
sudo filebeat -e modules enable mysql
sudo filebeat setup -e

#download
sudo mkdir /var/log/apache2
sudo mkdir /var/log/mysql
sudo wget -O /var/log/apache2/access.log https://raw.githubusercontent.com/measdot/data/master/access.log
sudo wget -O /var/log/apache2/error.log https://raw.githubusercontent.com/measdot/data/master/error.log
sudo wget -O /var/log/mysql/error.log https://raw.githubusercontent.com/measdot/data/master/mysql/error.log
sudo wget -O /var/log/mysql/error.log https://raw.githubusercontent.com/measdot/data/master/mysql/mysql-slow.log

#feed
sudo filebeat -e
