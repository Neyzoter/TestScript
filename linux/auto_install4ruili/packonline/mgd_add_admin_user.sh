#!/bin/bash

cat ./info/title
echo ""
echo "This tool is used to add admin user"
echo "Docker container can rw db with this user"
echo "[ATTENTION] Make mongodb run in NO-AUTH mode"
echo ""

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

# 添加root admin
admin4root="admin"
pwd4root="0xd90DEdteop54D"
adminDb4root="admin"
cmd_user="db.createUser({user:\\\""
cmd_pwd="\\\",pwd:\\\""
cmd_role="\\\",roles:[{role:\\\"root\\\",db:\\\"admin\\\"}]})"
cmd="$cmd_user$admin4root$cmd_pwd$pwd4root$cmd_role"
cmd_all0="echo \"$cmd\" | mongo $adminDb4root --shell"
echo $cmd_all0
eval $cmd_all0

# rcloud应用的数据库用户
admin4rcloud=`cat ./script/rcloud_configuration.properties | awk '/db.mongodb.user/' | sed -r "s#[ ]*##g" | sed -r "s#db.mongodb.user=##g"`
psw4rcloud=`cat ./script/rcloud_configuration.properties | awk '/db.mongodb.password/' | sed -r "s#[ ]*##g" | sed -r "s#db.mongodb.password=##g"`
adminDb4rcloud=`cat ./script/rcloud_configuration.properties | awk '/db.mongodb.adminDb/' | sed -r "s#[ ]*##g" | sed -r "s#db.mongodb.adminDb=##g"`

cmd_user="db.createUser({user:\\\""
cmd_pwd="\\\",pwd:\\\""
cmd_role="\\\",roles:[{role:\\\"readWrite\\\",db:\\\"data\\\"},{role:\\\"readWrite\\\",db:\\\"udp\\\"}]})"
cmd="$cmd_user$admin4rcloud$cmd_pwd$psw4rcloud$cmd_role"
cmd_all1="echo \"$cmd\" | mongo $adminDb4rcloud --shell"
echo $cmd_all1
eval $cmd_all1

# ota应用的数据库用户
admin4ota=`cat ./script/deploy.env | awk '/MONGODB_USRNAME/' | sed -r "s#[ ]*##g" | sed -r "s#MONGODB_USRNAME=##g"`
psw4ota=`cat ./script/deploy.env  | awk '/MONGODB_PASSWD/' | sed -r "s#[ ]*##g" | sed -r "s#MONGODB_PASSWD=##g"`
# old version : adminDb4ota=`cat ./script/deploy.env | awk '/MONGODB_URL/' | sed -r "s#[ ]*##g" | sed -r "s#MONGODB_URL=.*\/\/.*\/##g"`
adminDb4ota=`cat ./script/deploy.env | awk '/MONGODB_AUTH_DB/' | sed -r "s#[ ]*##g" | sed -r "s#MONGODB_AUTH_DB=##g"`

cmd_user="db.createUser({user:\\\""
cmd_pwd="\\\",pwd:\\\""
cmd_role="\\\",roles:[{role:\\\"readWrite\\\",db:\\\"$adminDb4ota\\\"}]})"
cmd="$cmd_user$admin4ota$cmd_pwd$psw4ota$cmd_role"
cmd_all2="echo \"$cmd\" | mongo $adminDb4ota --shell"
echo $cmd_all2
eval $cmd_all2


