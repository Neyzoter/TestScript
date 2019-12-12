#!/bin/bash

############get test path###############
if [ -z $1 ];then
 path="."
else
 path=$1
fi

if [ "${path:0:1}" = "/" ];then 
  if [ ! -d ${path} ];then
   # echo "create new path:${path}"
    mkdir -p ${path}
  fi
 # echo "absolute directory:${path}"
else
  pwd=`pwd`
  if [ ! -d "${pwd}/${path}" ];then
  # echo "create new path:${pwd}/${path}"
   mkdir -p ${pwd}/${path}
  fi
  path=${pwd}/${path}
 # echo "path:${path}"
fi

##########get data from df -h#############
df -h | while read line
do 
  #for var in $line
  line_path=`echo ${line} | awk -F' ' '{print $6}'`
  line_avail=`echo ${line} | awk -F' ' '{print $4}'`
   if [ "${line_path:0:1}" != "/" ]; then 
     continue
   fi

   if [ "${line_path}" = "/" ]; then
      root_avail=${line_avail}
     #echo "root_avail:${root_avail}"
     if [ -f /tmp/tmp_root_avail ];then 
       rm /tmp/tmp_root_avail
     fi
     echo ${root_avail} > /tmp/tmp_root_avail
     continue
   fi
 
  path_length=${#line_path}
  if [ "${path:0:${path_length}}" = "${line_path}" ];then
   # echo "${path} contain path:${line_path}" 
    path_avail=${line_avail}
    if [ -f /tmp/tmp_path_avail ];then
      rm /tmp/tmp_path_avail
    fi
    echo ${path_avail} > /tmp/tmp_path_avail
    break
  fi
  
done

#############get data from temp file###############
if [ -f /tmp/tmp_path_avail ];then
 path_avail=`cat /tmp/tmp_path_avail`
 rm /tmp/tmp_path_avail
fi
if [ -f /tmp/tmp_root_avail ];then
 root_avail=`cat /tmp/tmp_root_avail`
 rm /tmp/tmp_root_avail
fi


###################compute######################
if [ -z ${path_avail} ];then
#   echo "root_avail:${root_avail}"
#   echo "path_avail=${path_avail}"
   path_avail=${root_avail}
fi

echo "${path_avail}" >> /home/scc/code/TestScript/linux/disk_space.log
