#!/bin/bash

app="app"
db="db"
echo "choose app or db:"
read server

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

echo "Change *.sh to 777"
sudo chmod 777 *.sh

if [ $app = $server ];then
  echo "Preparing for \"$app\""
  # cp properties to /etc
  echo "Copying rcloud_configuration.properties to /usr/local/rcloud/"
  if [ ! -d "/usr/local/rcloud/" ]; then
    sudo mkdir -p /usr/local/rcloud/
  fi
  sudo cp ./script/rcloud_configuration.properties /usr/local/rcloud/
  # cp script to shell
  echo "Chmod 777 script"
  sudo chmod 777 ./script/updateCpuMemDisk4App.sh
  # first run, no dependency
  ./script/updateCpuMemDisk4App.sh 
  
elif [ $db = $server ];then
  echo "Preparing for \"$db\"" 
  # cp script to shell
  echo "Chmod 777 script"
  sudo chmod 777 ./script/updateCpuMemDisk4App.sh
fi

echo "Preparing end"


