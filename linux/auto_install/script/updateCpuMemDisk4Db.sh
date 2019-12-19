#!/bin/bash

# 先进入文件所在目录，防止调用时，将结果保存到其他目录下
cd $(dirname $0)

dir_cmd=`pwd`
dir=$dir_cmd


# 获取15分钟内cpu占用率
cpu_cmd=`uptime | sed -r "s/.*load average://" | gawk '{print $3}'`
cmd_left="db.dbState.update({},{\$set:{'db_cpu_usagerate_15min':'"
cmd_right="'}},{upsert:true});"
cmd="$cmd_left$cpu_cmd$cmd_right"
# data : 需要访问的数据库；admin : 管理员保存的数据库
# echo $cmd | mongo data -u [USER_NAME] -p [PASSWARD] --authenticationDatabase [ADMIN_DB] --shell
echo $cmd | mongo data --shell


# 获取cpu逻辑核个数
kernel_cmd=`cat /proc/cpuinfo |grep "processor"|wc -l`
cmd_left="db.dbState.update({},{\$set:{'db_cpu_logicalKernel_num':'"
cmd_right="'}},{upsert:true});"
cmd="$cmd_left$kernel_cmd$cmd_right"
echo $cmd | mongo data --shell

# 获取空闲磁盘空间
if [ -z $1 ];then
 path=$dir
else
 path=$1
fi
space_cmd=`df -BG $path | awk 'NR==2{print $4}' | sed "s/G//"`
cmd_left="db.dbState.update({},{\$set:{'db_disk_freeSpaceG':'"
cmd_right="'}},{upsert:true});"
cmd="$cmd_left$space_cmd$cmd_right"
echo $cmd | mongo data --shell

# 获取内存利用率
mem_cmd=`free | grep "Mem:" |  awk '{print ($3)/$2}'`
cmd_left="db.dbState.update({},{\$set:{'db_mem_usagerate':'"
cmd_right="'}},{upsert:true});"
cmd="$cmd_left$mem_cmd$cmd_right"
echo $cmd | mongo data --shell

