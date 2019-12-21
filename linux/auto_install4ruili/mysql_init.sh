#!/bin/bash


echo "This tool is used to init mysql table"
echo ""
cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

# sql文件位置
p="./script/" 
# 读取用户
dbUser=`cat ./script/deploy.env | awk '/MYSQL_USRNAME/' | sed -r "s#[ ]*##g" | sed -r "s#MYSQL_USRNAME=##g"`
# 从deploy.env读取密码
dbPassword=`cat ./script/deploy.env | awk '/MYSQL_PASSWD/' | sed -r "s#[ ]*##g" | sed -r "s#MYSQL_PASSWD=##g"`
# db名称
dbName=`cat ./script/deploy.env | awk '/MYSQL_URL/' | sed -r "s#[ ]*##g" | sed -r "s#MYSQL_URL=.*\/\/.*\/##g"`

mysql -u $dbUser -p$dbPassword -e "create database $dbName"

for f in `ls $p*.sql`
  do
  echo $f;
  mysql -u $dbUser -p$dbPassword -f $dbName -e "source $f";
  done
echo 'Finished!'
