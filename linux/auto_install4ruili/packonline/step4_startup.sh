#!/bin/bash

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

cat ./info/title
echo ""

# 实现修改脚本地址server.props.addr, 即应用服务器的状态脚本和脚本输出属性
## r:使用拓展正则, i:直接修改原文件
sudo sed -ri "s#server.props.addr=.*#server.props.addr=$dir\/script\/space.properties#g" ./script/rcloud_configuration.properties
# 将配置文件更新
if [ ! -d "/usr/local/rcloud/" ]; then
  echo "Creating /usr/local/rcloud/"
  sudo mkdir -p /usr/local/rcloud/
fi
echo "Cp rcloud_configuration.properties to /usr/local/rcloud/"
sudo cp ./script/rcloud_configuration.properties /usr/local/rcloud/

# 初始化space.properties
echo "updateCpuMemDisk4App.sh exec once"
sudo ./script/updateCpuMemDisk4App.sh

# 运行Docker镜像（应用）
echo "docker container prune"
sudo docker container prune

echo "Docker containers are running ..."

sudo docker run --env-file=./script/deploy.env --name ota_backend -d -p 9090:9090 -p 9092:9099 ota_backend:0.3.5

sudo docker run --name ota_frontend -d -p 9099:80 ota_frontend:0.3.5

sudo docker run --name rcloud -d -p 8089:8089 -p 5001:5001/udp -v /usr/local/rcloud/:/usr/local/rcloud/ -v $dir/script/:$dir/script/ neyzoter/rcloud:1.0.0

echo ""
sudo docker ps
