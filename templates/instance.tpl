#!/bin/bash

sudo apt-get update
sudo apt install docker.io -y
sudo apt install wget curl -y
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# sudo git clone https://github.com/meriem-mounchid/Inception-2.git app
sudo chmod 777 /app/.env 
sudo mkdir -p /home/ubuntu/wordpress_nginx
sudo mkdir -p /home/ubuntu/mariadb_data
# sudo echo "MYIP="$(curl http://169.254.169.254/latest/meta-data/instance-id) >> /app/.env
# sudo docker-compose -f /app/docker-compose.yaml up --build -d