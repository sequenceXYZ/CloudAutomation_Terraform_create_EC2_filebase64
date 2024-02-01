#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
echo '<html><h3> ICP Winter Bootcamp 2024 student name: Agnija Vjakse </h3></html>' > index.html
