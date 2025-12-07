source ./common.sh

echo installed mysql
dnf install mysql-server -y &>> $log_file
STATUS_PRINT $?

systemctl enable mysqld
systemctl start mysqld  
mysql_secure_installation --set-root-pass RoboShop@1