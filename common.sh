PATH=$(pwd)
log_file=/tmp/roboshop.log
# rm -rf $log_file
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
STATUS_PRINT() {
    if [ $1 -ne 0 ]
    then
       echo -e $G SUCCESS $N
    else
       echo -e $R FAILURE $N
       exit 1
    fi
}
APP_PREREQ() {
    echo Create Application User
    id roboshop &>>$log_file
    if [ $? -ne 0 ]
    then
      useradd roboshop &>>$log_file
    fi
    STATUS_PRINT $?
    echo create app directory
    mkdir /app &>>$log_file
    STATUS_PRINT $?
    echo Download the service_file
    curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>> $log_file
    STATUS_PRINT $?
    cd /app 
    echo unzip the service_file
    unzip /tmp/$app_name.zip &>> $log_file
    STATUS_PRINT $?
}
SYSTEMD_SETUP() {
    echo copying the service file
    cp $PATH/$app_name.service /etc/systemd/system/$app_name.service $log_file &>> $log_file
    STATUS_PRINT $?
    systemctl daemon-reload
    systemctl enable $app_name 
    echo start the service
    systemctl start $app_name 
    STATUS_PRINT $?
}
NODEJS() {
    echo disable nodeJs
    dnf module disable nodejs -y &>> $log_file
    STATUS_PRINT $?
    echo enable NodeJS
    dnf module enable nodejs:20 -y &>> $log_file
    STATUS_PRINT $?
    echo Install NodeJS
    dnf install nodejs -y &>> $log_file
    STATUS_PRINT $?
    APP_PREREQ
    echo install npm dependencies
    npm install &>> $log_file
    STATUS_PRINT $?
    SYSTEMD_SETUP
}
JAVA() {
    dnf install maven -y &>> $log_file
    STATUS_PRINT $?
    APP_PREREQ
    echo maven clean package
    mvn clean package &>> $log_file
    STATUS_PRINT $?
    echo move the jarfile
    mv target/$app_name-1.0.jar $app_name.jar &>> $log_file
    STATUS_PRINT $?
    SYSTEMD_SETUP
}
PYTHON() {
    echo install python
    dnf install python3 gcc python3-devel -y &>> $log_file
    STATUS_PRINT $?
    APP_PREREQ
    echo install python dependencies
    pip3 install -r requirements.txt &>> $log_file
    STATUS_PRINT $?
    SYSTEMD_SETUP
}