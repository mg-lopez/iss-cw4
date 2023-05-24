#!/bin/bash

echo 'Ensuring SELinux is installed:'
sudo yum install selinux-policy-devel

echo 'Ensuring docker is running'
sudo systemctl start docker

echo 'Ensuring that docker has SELinux enabled:'
sudo sed -i 's|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd --selinux-enabled|' /usr/lib/systemd/system/docker.service

echo 'Restarting docker...'
sudo systemctl daemon-reaload

echo 'confirm docker is running with SELinux enabled:'
docker info | grep -A5 Security

echo 'Compiling the restrive .te SELinux Policy for the Database:'
cd /home/csc/iss2023-lima/builds/dbserver
sudo make -f /usr/share/selinux/devel/Makefile docker_dbserver_c.pp
cd /home/csc/iss2023-lima/builds/dbserver
sudo semodule -i docker_dbserver_c.pp


echo 'Compiling the restrive .te SELinux Policy for the Database:'
cd /home/csc/iss2023-lima/builds/webserver
sudo make -f /usr/share/selinux/devel/Makefile docker_webserver_c.pp
cd /home/csc/iss2023-lima/builds/webserver
sudo semodule -i docker_webserver_c.pp

echo 'Ensure that SELinux is enforcing:'
sudo setenforce 1; getenforce

echo 'Verify the policies have implemented correctly:'
sudo semodule -l | grep docker_
