#!/bin/bash

mkdir -p /run/php-fpm/
/usr/sbin/nginx
/usr/sbin/php-fpm -F

chown apache:apache /usr/share/nginx/html/*.php
