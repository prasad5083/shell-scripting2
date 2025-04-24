#!/bin/bash

component=frontend
logfile="/tmp/${component}.log"
ID=$(id -u)

# Check for root privileges
if [ $ID -ne 0 ]; then
  echo -e "\e[31mThis script must be run as root.\e[0m"
  exit 1
fi

# Function to print status
stat() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}

echo "Installing Nginx:"
yum install nginx -y &>> $logfile
stat $?

echo "Downloading frontend component:"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo "Cleaning up old HTML content:"
rm -rf /usr/share/nginx/html/* &>> $logfile
stat $?

echo "Extracting frontend content:"
unzip /tmp/${component}.zip -d /tmp &>> $logfile
mv /tmp/frontend-main/* /usr/share/nginx/html/ &>> $logfile
stat $?

echo "Setting correct file permissions:"
chown -R nginx:nginx /usr/share/nginx/html
chmod -R 755 /usr/share/nginx/html
stat $?

echo "Creating Nginx config:"
cat <<EOF > /etc/nginx/default.d/roboshop.conf
location / {
    root   /usr/share/nginx/html;
    index  index.html index.htm;
}
EOF
stat $?

echo "Enabling and restarting Nginx:"
systemctl enable nginx &>> $logfile
systemctl restart nginx &>> $logfile
stat $?

#echo "Configuring firewall:"
#firewall-cmd --add-port=80/tcp --permanent &>> $logfile
#firewall-cmd --reload &>> $logfile
#stat $?

echo -e "\n\e[32mFrontend setup complete! Visit http://<EC2-IP> to verify.\e[0m"
