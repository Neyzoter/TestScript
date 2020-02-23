#!/bin/bash

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

cat ./info/title
echo ""
app="app"
db="db"
echo "choose app or db:"
read server

if [ $app = $server ];then
  echo "Installing for \"$app\""  
  # docker
  ## install docker
  echo "Installing Docker"
  sudo yum -y install yum-utils device-mapper-persistent-data lvm2
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum -y install docker-ce docker-ce-cli containerd.io
  echo "Docker installed OK"
  echo "Startup Docker"
  sudo systemctl start docker
  ## install docker images
  echo "Entering $dir"
  echo "Loading docker images"
  sudo docker load < ./app/rcloud-*.tar
  sudo docker load < ./app/ota_backend-*.tar
  sudo docker load < ./app/ota_frontend-*.tar
  echo "Loaded docker image OK"
  docker_images=`sudo docker images`
  echo "$docker_images"
  # redis
  echo "Installing redis"
  sudo yum -y install redis
  echo "Redis installed OK"
  echo "Setting bind 0.0.0.0"
  sudo sed -ri "s#bind.*#bind 0.0.0.0#g" /etc/redis.conf
  echo "Starting Redis"
  systemctl start redis
elif [ $db = $server ];then
  echo "Installing for \"$db\"" 
  # mongodb
  echo "Installing mongodb"
  sudo cp ./mongodb/mongodb-org-4.0.repo /etc/yum.repos.d/
  sudo yum -y install mongodb-org
  echo "Installed mongodb"
  if [ ! -d "/data/db/" ]; then
    echo "Making dir /data/db/ for mongod"
    sudo mkdir -p /data/db/
  fi
  echo "Chowning mongod to /data/db/"
  sudo chown -R mongod:mongod /data/db/
  echo "Changing dbPath to /data/db/"
  sudo sed -ri "s#dbPath:.*#dbPath: /data/db/#g" /etc/mongod.conf

  if [ ! -d "/data/log/" ]; then
    echo "Making dir /data/log/ for mongod"
    sudo mkdir -p /data/log/
  fi
  echo "Chowning mongod to /data/log/"
  sudo chown -R mongod:mongod /data/log/
  echo "Changing logPath to /data/log/mongod.log"
  sudo sed -ri "s#path:.*#path: /data/log/mongod.log#g" /etc/mongod.conf
  echo "Changing bindIp to 0.0.0.0"
  sudo sed -ri "s#bindIp:.*#bindIp: 0.0.0.0#g" /etc/mongod.conf
  # rm mariadb
  echo "Uninstalling mariadb"
  sudo rpm -qa|grep mariadb
  sudo rpm -e --nodeps mariadb-libs
  echo "Uninstalled mariadb OK"
  # mysql
  echo "Installing mysql"
  sudo wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
  sudo yum -y install mysql57-community-release-el7-10.noarch.rpm
  sudo yum -y install mysql-community-server
  ## wait for 1second
  ti1=`date +%s`
  ti2=`date +%s`
  i=$(($ti2 - $ti1 ))
  while [[ "$i" -ne "1" ]]
  do
    ti2=`date +%s`
    i=$(($ti2 - $ti1 ))
  done
  echo "Installed mysql OK"
  echo "Setting bind-address=0.0.0.0"
  if grep -q "bind-address" /etc/my.cnf;then
    sudo sed -ri "s#bind-address.*#bind-address=0.0.0.0#g" /etc/my.cnf
  else
    sudo echo "bind-address=0.0.0.0" >> /etc/my.cnf
  fi
  echo "starting mysqld.service"
  systemctl start mysqld
  echo "MySQL Initial PASSWORD : "
  grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'
  
fi

