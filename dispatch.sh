source ./common.sh
app_name=dispatch
echo golang installed
dnf install golang -y &>> $log_file
# useradd roboshop
# mkdir /app 
# curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip 
# cd /app 
# unzip /tmp/dispatch.zip
APP_PREREQ
cd /app 
go mod init dispatch
go get 
go build
# cp dispatch.service /etc/systemd/system/dispatch.service
# systemctl daemon-reload
# systemctl enable dispatch 
# systemctl start dispatch
SYSTEMD_SETUP