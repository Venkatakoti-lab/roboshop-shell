source ./common.sh
app_name=redis

echo disable $app_name
dnf module disable $app_name -y  &>> $log_file
STATUS_PRINT $?

echo enable $app_name
dnf module enable $app_name:7 -y  &>> $log_file
STATUS_PRINT $?

echo install $app_name
dnf install $app_name -y   &>> $log_file
STATUS_PRINT $?

echo update $app_name configuration_file
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ -c protected-mode no' /etc/redis/redis.conf
STATUS_PRINT $?


systemctl enable $app_name  &>> $log_file
echo started $app_name
systemctl start $app_name  &>> $log_file
STATUS_PRINT $?
