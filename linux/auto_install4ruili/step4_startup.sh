#!/bin/bash

echo "######################################"
echo "#                                    #"
echo "#   浙江大学NESC课题组物联网实验室   #"
echo "#      IoT Lab of ZJU NESC Group     #"
echo "#                                    #"
echo "######################################"
echo ""

cd $(dirname $0)

dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

# 实现修改脚本地址server.props.addr, 即应用服务器的状态脚本和脚本输出属性
## r:使用拓展正则, i:直接修改原文件
sudo sed -ri "s#server.props.addr=.*#server.props.addr=$dir\/script\/space.properties#g" ./script/rcloud_configuration.properties
# 将配置文件更新
if [ ! -d "/usr/local/rcloud/" ]; then
  echo "Creating /usr/local/rcloud/"
  sudo mkdir -p /usr/local/rcloud/
fi
sudo cp ./script/rcloud_configuration.properties /usr/local/rcloud/

# 初始化space.properties
sudo ./script/updateCpuMemDisk4App.sh

# 运行Docker镜像（应用）

sudo docker run --env-file=./script/deploy.env --name ota_backend -d -p 9090:9090 -p 9092:9099 registry.cn-hangzhou.aliyuncs.com/ruili/ota:0.3.5_deploy

sudo docker run --name ota_frontend -d -p 9099:80 registry.cn-hangzhou.aliyuncs.com/ruili/ota_fronted:0.3.5

sudo docker run --name rcloud -d -p 8089:8089 -p 5001:5001 -v /usr/local/rcloud/:/usr/local/rcloud/ -v $dir/script/:$dir/script/ neyzoter/rcloud:1.0.0
