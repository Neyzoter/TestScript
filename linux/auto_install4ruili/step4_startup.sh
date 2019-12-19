#!/bin/bash

cd $(dirname $0)

dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

# 实现修改脚本地址server.props.addr, 即应用服务器的状态脚本和脚本输出属性
## r:使用拓展正则, i:直接修改原文件
sed -ri "s#server.props.addr=.*#server.props.addr=$dir\/script\/space.properties#g" ./script/rcloud_configuration.properties
# 将配置文件更新
if [ ! -d "/usr/local/rcloud/" ]; then
  echo "Creating /usr/local/rcloud/"
  sudo mkdir -p /usr/local/rcloud/
fi
sudo cp ./script/rcloud_configuration.properties /usr/local/rcloud/

# 初始化space.properties
./script/updateCpuMemDisk4App.sh

# 运行Docker镜像（应用）
sudo docker run --network=host -v /usr/local/rcloud/:/usr/local/rcloud/ -v $dir/script/:$dir/script/ neyzoter/rcloud:1.0.0