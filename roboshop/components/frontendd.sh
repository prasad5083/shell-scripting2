#!/bin/bash

component=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
  echo -e "\e[31m this script is only executed by privileged user \e[0m"
  exit 1
fi 

stat() {
  if [ $1 -eq 0 ] ; then
    echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
    exit 2
  fi
}

logfile="/tmp/${component}.log"

echo "install nginx : "
yum install nginx unzip -y &>> $logfile
stat $? 

echo "downloading the front end component"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "performing clean up "
cd /usr/share/nginx/html  
rm -rf * &>> $logfile
stat $?

echo -n "extracting ${component} component : "
unzip /tmp/${component}.zip &>> $logfile
mv ${component}-main/* . 
mv static/* . 
rm -rf ${component}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo "starting the ${component} service"
systemctl enable nginx &>> $logfile
systemctl start nginx &>> $logfile
stat $?
