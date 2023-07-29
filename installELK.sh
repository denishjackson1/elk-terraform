#!/bin/bash

# Install Java 17
sudo apt update
sudo apt install openjdk-17-jdk
sudo java -version

# Install nginx
sudo apt-get install nginx -y
sudo mv /tmp/kibana-nginx /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/kibana-nginx /etc/nginx/sites-enabled/
sudo nginx -t
sudo service nginx restart

# Install Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.0-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.0-amd64.deb.sha512
shasum -a 512 -c elasticsearch-8.9.0-amd64.deb.sha512 
sudo dpkg -i elasticsearch-8.9.0-amd64.deb
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

# Install Kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.9.0-amd64.deb
shasum -a 512 kibana-8.9.0-amd64.deb 
sudo dpkg -i kibana-8.9.0-amd64.deb
sudo systemctl enable kibana
sudo systemctl start kibana

# Install logstash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash

# Install Metricbeat
sudo wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.9.0-amd64.deb
sudo dpkg -i metricbeat-8.9.0-amd64.deb
sudo systemctl enable metricbeat
sudo systemctl start metricbeat

# Start logstash
sudo mv /tmp/apache.conf /etc/logstash/conf.d/apache.conf
sleep 15
sudo systemctl enable logstash
sudo service logstash start