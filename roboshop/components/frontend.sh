#!/bin/bash

component=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
 echo -e "\e[31m this script is only execurted by only previlaged user \e[0m"
 exit 1
fi 
echo " install nginx : "

yum install nginx -y &>> "/tmp/${component}.log"

if [ $? -eq 0 ] ; then
 echo -e " \e[31m success \e[0m
else
 echo -e "\e[31m failure \e[0m"
fi  

# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx



#Let's download the HTDOCS content and deploy it under the Nginx path.

# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

#Deploy in Nginx Default Location.

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf




