#!/bin/bash

app="app"
db="db"
echo "choose app or db:"
read server

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"


if [ $app = $server ];then
  echo "Installing for \"$app\""  
  # docker
  ## install docker
  cd ./docker
  echo "Entering $dir"
  echo "Installing Docker"
  sudo rpm -ivh *.rpm --nodeps --force
  echo "Docker installed OK"
  echo "Startup Docker"
  systemctl start docker
  ## install docker images
  cd ../app
  echo "Entering $dir"
  echo "Loading docker images"
  sudo docker load < ./rcloud-*.tar
  sudo docker load < ./ota_backend.tar
  sudo docker load < ./ota_frontend.tar
  echo "Loaded docker image OK"
  docker_images=`sudo docker images`
  echo "$docker_images"
  # redis
  cd ../redis
  echo "Entering $dir"
  echo "Installing redis"
  sudo rpm -ivh *.rpm --nodeps --force
  echo "Redis installed OK"
  echo "Starting Redis"
  service redis start
elif [ $db = $server ];then
  echo "Installing for \"$db\"" 
  # mongodb
  cd ./mongodb
  echo "Entering $dir"
  echo "Installing mongodb"
  sudo rpm -ivh *.rpm --nodeps --force
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
  cd ../mysql
  echo "Entering $dir"
  echo "Installing mysql"
  sudo rpm -ivh *.rpm --nodeps --force
  echo "Installed mysql OK"
  echo "Setting bind-address=0.0.0.0"
  if grep -q "bind-address" /etc/my.cnf;then
    sudo sed -ri "s#bind-address.*#bind-address=0.0.0.0#g" /etc/my.cnf
  else
    sudo echo "bind-address=0.0.0.0" >> /etc/my.cnf
  fi
  echo "starting mysqld.service"
  service mysqld start
  echo "MySQL Initial PASSWORD : "
  grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'
  
fi

