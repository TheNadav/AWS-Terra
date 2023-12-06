#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install default-jre -y
sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash -y
sudo /usr/share/logstash/bin/logstash-plugin install microsoft-logstash-output-azure-loganalytics
sudo wget https://raw.githubusercontent.com/TheNadav/Logstash-AWS-WAF/main/logstash.conf -P /etc/logstash/conf.d/