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
  sudo systemctl start docker
  ## install docker images
  cd ../app
  echo "Entering $dir"
  echo "Loading docker images"
  sudo docker load < ./rcloud-*.tar
  echo "Loaded docker image : neyzoter/rcloud"
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
  echo "Chowning mongod to /data/db"
  sudo chown -R mongod:mongod /data/db/

  if [ ! -d "/root/mongodb/log/" ]; then
    echo "Making dir /root/mongodb/log/ for mongod"
    sudo mkdir -p /root/mongodb/log/
  fi
  echo "Changing logPath to /root/mongodb/log/mongod.log"
  sed -ri "s#path:.*#path: /root/mongodb/log/mongod.log#g" /etc/mongod.conf
  if [ ! -d "/root/mongodb/db/" ]; then
    echo "Making dir /root/mongodb/db/ for mongod"
    sudo mkdir -p /root/mongodb/db/
  fi
  echo "Changing dbPath to /root/mongodb/db"
  sed -ri "s#dbPath:.*#dbPath: /root/mongodb/db#g" /etc/mongod.conf
  echo "Chowning mongod to /root/mongodb/"
  sudo chown -R mongod:mongod /root/mongodb/
  echo "Changing bindIp to 0.0.0.0"
  sed -ri "s#bindIp:.*#bindIp: 0.0.0.0#g" /etc/mongod.conf
  
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
    sed -ri "s#bind-address.*#bind-address=0.0.0.0#g" /etc/my.cnf
  else
    echo "bind-address=0.0.0.0" >> /etc/my.cnf
  fi
  echo "starting mysqld.service"
  service mysqld start
  echo "MySQL Initial PASSWORD : "
  grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'
  
fi

