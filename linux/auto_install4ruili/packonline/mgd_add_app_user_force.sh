#!/bin/bash
cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

cat ./info/titile
echo ""
echo "This tool is used to add app user"
echo "Client can login with this user"
echo "[ATTENTION] Make mongodb run in NO-AUTH mode"
echo ""
data_cmd=`date +%Y-%m-%dT%H:%M:%S`

function addUserForce()
{
  echo "Username:"
  read user
  echo "Passward:"
  read password
  insert_cmd="db.admin.insert({'userName':\"$user\",'userKey':\"$password\",'uu
serPrivilege':"1",'userCreate':\"$data_cmd\"})"
  echo $insert_cmd | mongo data --shell
  
  echo "continue?(yes or no)"
  read ctn
  if [ "$ctn" = "yes" ];then
    addUserForce
  fi
}

addUserForce
