#!/bin/bash

# 先进入文件所在目录，防止调用时，将结果保存到其他目录下
cd $(dirname $0)

dir_cmd=`pwd`
dir=$dir_cmd

# 获取15分钟内cpu占用率
cpu_cmd=`uptime | sed -r "s/.*load average://" | gawk '{print $3}'`
echo "server.cpu.usagerate.15min=$cpu_cmd" > $dir/space.properties

# 获取cpu逻辑核个数
kernel_cmd=`cat /proc/cpuinfo |grep "processor"|wc -l`
echo "server.cpu.logicalKernel.num=$kernel_cmd" >> $dir/space.properties

# 获取空闲磁盘空间
if [ -z $1 ];then
 path=$dir 
else
 path=$1
fi
space_cmd=`df -BG $path | awk 'NR==2{print $4}' | sed "s/G//"`
echo "server.disk.freeSpaceG=$space_cmd" >> $dir/space.properties

# 获取内存利用率
mem_cmd=`free | grep "Mem:" |  awk '{print ($3)/$2}'`
echo "server.mem.usagerate=$mem_cmd" >> $dir/space.properties
