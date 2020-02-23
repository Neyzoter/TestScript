#!/bin/bash

echo "######################################"
echo "#                                    #"
echo "#   浙江大学NESC课题组物联网实验室   #"
echo "#      IoT Lab of ZJU NESC Group     #"
echo "#                                    #"
echo "######################################"
echo ""
echo "This tool is used to add app user"
echo "Client can login with this user"
echo "[ATTENTION] Make mongodb run in NO-AUTH mode"
echo ""
data_cmd=`date +%Y-%m-%dT%H:%M:%S`
function addUser()
{
  echo "Username:"
  read user
  check_cmd="db.admin.find({'userName':\"$user\"}).count()"
  count=`echo $check_cmd | mongo data --shell | awk 'NR==5{print}'`
  if [ "$count" = "0" ];then
    echo "$user is available!"
    echo "Passward:"
    read password
    insert_cmd="db.admin.insert({'userName':\"$user\",'userKey':\"$password\",'userPrivilege':"1",'userCreate':\"$data_cmd\"})"
    echo $insert_cmd | mongo data --shell
  else
    echo "[ERROR] $user is used by others!"
  fi

  echo "continue?(yes or no)"
  read ctn
  if [ "$ctn" = "yes" ];then
    addUser
  fi
}

addUser
