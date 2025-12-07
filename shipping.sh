# dnf install maven -y
# useradd roboshop
# mkdir /app 
# curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip 
# cd /app 
# unzip /tmp/shipping.zip
# cd /app 
# mvn clean package 
# mv target/shipping-1.0.jar shipping.jar 
# cp shipping.service /etc/systemd/system/shipping.service
# systemctl daemon-reload
# systemctl enable shipping 
# systemctl start shipping
source ./common.sh
app_name=shipping
JAVA

echo installing mysql
dnf install mysql -y &>> $log_file
STATUS_PRINT $?

for file in schema app-user master-data
do 
echo load $file schema
mysql -h mysql-dev.kanakam.shop -uroot -pRoboShop@1 < /app/db/$file.sql
STATUS_PRINT $?
done
# mysql -h mysql-dev.kanakam.shop -uroot -pRoboShop@1 < /app/db/schema.sql
# mysql -h mysql-dev.kanakam.shop -uroot -pRoboShop@1 < /app/db/app-user.sql
# mysql -h mysql-dev.kanakam.shop -uroot -pRoboShop@1 < /app/db/master-data.sql
echo restart $app_name service
systemctl restart $app_name
STATUS_PRINT $?


