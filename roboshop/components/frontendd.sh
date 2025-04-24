#!/bin/bash

component=frontend
ID=$(id -u)

# Check if the script is executed by a privileged user
if [ $ID -ne 0 ] ; then
  echo -e "\e[31mThis script must be executed by a privileged user\e[0m"
  exit 1
fi 

# Function to check status of commands
stat() {
  if [ $1 -eq 0 ] ; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}

logfile="/tmp/${component}.log"

echo "Installing Nginx: "
yum install nginx -y &>> $logfile
stat $? 

echo "Downloading the frontend component..."
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Performing cleanup..."
cd /usr/share/nginx/html || exit 1
rm -rf * &>> $logfile
stat $?

echo -n "Extracting ${component} component: "
unzip /tmp/${component}.zip &>> $logfile
mv ${component}-main/* . 
mv ${component}-main/static/* . &>> $logfile
rm -rf ${component}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo "Configuring firewall..."
firewall-cmd --add-port=80/tcp --permanent &>> $logfile
firewall-cmd --reload &>> $logfile
stat $?

echo "Starting the ${component} service..."
systemctl enable nginx &>> $logfile
systemctl restart nginx &>> $logfile
stat $?
