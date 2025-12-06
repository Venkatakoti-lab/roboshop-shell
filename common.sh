APP_PREREQ() {
    useradd roboshop
    mkdir /app 
    curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip 
    cd /app 
    unzip /tmp/$app_name.zip
}
SYSTEMD_SETUP() {
    cp $app_name.service /etc/systemd/system/$app_name.service
    systemctl daemon-reload
    systemctl enable $app_name 
    systemctl start $app_name 
}
NODEJS() {
    dnf module disable nodejs -y
    dnf module enable nodejs:20 -y
    dnf install nodejs -y
    APP_PREREQ
    npm install
    SYSTEMD_SETUP
}
JAVA() {
    dnf install maven -y
    APP_PREREQ
    mvn clean package
    mv target/$app_name-1.0.jar $app_name.jar 
    SYSTEMD_SETUP
}
PYTHON() {
    dnf install python3 gcc python3-devel -y
    APP_PREREQ
    pip3 install -r requirements.txt
    SYSTEMD_SETUP
}