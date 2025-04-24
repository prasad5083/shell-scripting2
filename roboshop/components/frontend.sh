#!/bin/bash

component=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
 echo -e "\e[31m this script is only execurted by only previlaged user \e[0m"
 exit 1
fi 
stat() {
if [ $1 -eq 0 ] ; then
 echo -e " \e[31m success \e[0m"
else
 echo -e "\e[31m failure \e[0m"
 exit 2
fi
}
logfile="/tmp/${component}.log"

echo " install nginx : "

yum install nginx -y &>> logfile

stat $? 

echo "downoding the front end component"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

stat $?

echo -n -e "  performing clean up "

cd /usr/share/nginx/html  
rm -rf * &>> logfile
stat $?

echo -n " extracting ${component} component : "
unzip /tmp/${component}.zip &>> logfile
mv static/* . &>> logfile
rm -rf ${component}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf


# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx



#Let's download the HTDOCS content and deploy it under the Nginx path.


#Deploy in Nginx Default Location.






