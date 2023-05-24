#!/bin/bash

# Ensuring docker is running
sudo systemctl start docker

# Creates docker network
docker network create --subnet=198.51.100.0/24 iss2023/lima_n

# Change directory to 'dbserver'
cd /home/csc/iss2023-lima/builds/dbserver

# Builds database image from Dockerfile
sudo docker build -t iss2023/lima-db_i .

chmod +x strip-cmd
chmod +x stip-image
sudo ./strip-cmd

# Change directory to 'webserver'
cd /home/csc/iss2023-lima/builds/webserver

# Builds webserver image from Dockerfile
sudo docker build -t iss2023/lima-web_i .

chmod +x strip-cmd
chmod +x stip-image
sudo ./strip-cmd
