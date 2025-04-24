#!/bin/bash

component=frontend
ID=$(id -u)

if [ $ID -ne 0 ] ; then
  echo -e "\e[31m this script is only execurted by only previlaged user \e[0m"
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

echo " install nginx : "
yum install nginx -y &>> $logfile
stat $? 

echo "downoding the front end component"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n -e "  performing clean up "
cd /usr/share/nginx/html  
rm -rf * &>> $logfile
stat $?

echo -n " extracting ${component} component : "
unzip /tmp/${component}.zip &>> $logfile
mv ${component}-main/* . 
mv ${component}-main/static/* . &>> $logfile
rm -rf ${component}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

#echo " configuring firewall "
#firewall-cmd --add-port=22/tcp --permanent &>> $logfile
#firewall-cmd --reload &>> $logfile
#stat $?


echo " starting the ${component} service "
systemctl enable nginx &>> $logfile
systemctl start nginx &>> $logfile
stat $?
