#!/bin/bash
i=1;

MAX_INSERT_ROW_COUNT=$1;
while [ $i -le $MAX_INSERT_ROW_COUNT ]
do
mysql -uroot -pRoot123456@ afs -e "insert into school.fota_images (gid,firmware_id) values ('$i','FIRMWARE_$i');"
echo "INSERT HELLO $i @@ $d"
i=$(($i+1))
sleep 0.01
done
exit 0


#CREATE TABLE `fota_images` (
#  `gid` int(255) PRIMARY KEY NOT NULL AUTO_INCREMENT,
#  `firmware_id` varchar(32) NOT NULL);