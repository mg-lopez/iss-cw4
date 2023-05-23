#!/bin/bash

# Ensuring docker is running
sudo systemctl start docker

echo 'Ensuring SELinux is installed:'
sudo yum install selinux-policy-devel

echo 'Ensuring that docker has SELinux enabled:'
sudo sed -i 's|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd --selinux-enabled|' /usr/lib/systemd/system/docker.service

echo 'Restarting docker...'
sudo systemctl daemon-reload

echo 'confirm docker is running with SELinux enabled:'
docker info | grep -A5 Security

cd /home/csc/iss2023-lima/builds/dbserver

echo 'Compiling the restrive .te SELinux Policy for the Database:'
sudo make -f /usr/share/selinux/devel/Makefile iss2023-lima-db_c.pp
sudo semodule -i iss2023-lima-db_c.pp

cd /home/csc/iss2023-lima/builds/webserver

echo 'Compiling the restrive .te SELinux Policy for the Database:'
sudo make -f /usr/share/selinux/devel/Makefile iss2023-lima-web_c.pp
sudo semodule -i iss2023-lima-web_c.pp

echo 'Ensure that SELinux is enforcing:'
sudo setenforce 1; getenforce

echo 'Verify the policies have implemented correctly:'
sudo semodule -l | grep iss2023
