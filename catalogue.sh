source ./common.sh
app_name=catalogue
NODEJS
# dnf module disable nodejs -y
# dnf module enable nodejs:20 -y
# dnf install nodejs -y
# useradd roboshop
# mkdir /app 
# curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
# cd /app 
# unzip /tmp/catalogue.zip
# npm install
# cp catalogue.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl enable catalogue 
# systemctl start catalogue
# cp  mongo.repo /etc/yum.repos.d/mongo.repo
echo install mongodb
dnf install mongodb-mongosh -y &>> $log_file
STATUS_PRINT $?
echo load the schema
mongosh --host mongodb-dev.kanakam.shop </app/db/master-data.js &>> $log_file
STATUS_PRINT $?
