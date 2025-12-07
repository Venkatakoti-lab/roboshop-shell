source ./common.sh

echo install rabitmq
dnf install rabbitmq-server -y &>> $log_file
STATUS_PRINT $?

systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo rabitmq add user
rabbitmqctl add_user roboshop roboshop123 &>> $log_file
STATUS_PRINT $?

echo rabitmq set password
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $log_file
STATUS_PRINT $?
