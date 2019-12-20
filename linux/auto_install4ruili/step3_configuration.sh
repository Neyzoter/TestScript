#!/bin/bash


cd $(dirname $0)

dir_cmd=`pwd`
dir=$dir_cmd

echo ""
echo "Please configure manually!"
echo ""
echo "APP SERVER : "
echo " 1.Redis startup when reboot"
echo "    hint1   : systemctl enable redis"
echo " 2.Docker startup when reboot"
echo "    hint1   : systemctl enable docker"
echo " 3.crontab run $dir/script/updateCpuMemDisk4App.sh"
echo "    hint1.1 : crontab -e"
echo "    hint1.2 : */20 * * * * $dir/script/updateCpuMemDisk4App.sh"
echo "    hint2   : systemctl enable crond.service"
echo " 4.rcloud_configuration.properties configure"
echo "    hint1   : server.props.addr auto changed by step4_startup.sh"
echo " 5.deploy.env"
echo ""
echo "DB SERVER : "
echo " 1.MongoDB configuration"
echo "    hint1.1 : vim /etc/mongod.conf"
echo "    hint1.2 : logPath and dbPath"
echo "    hint1.3 : bindIP: 0.0.0.0"
echo "    hint2   : systemctl enable mongod"
echo "    hint3   : mgd_add_app_user.sh"
echo " 2.MySQL configuration"
echo "    hint1   : vim /etc/my.cnf"
echo "    hint2   : systemctl enable mysqld"
echo "    hint3.1 : mysql -u root -p"
echo "    hint3.2 : > SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');"
echo " 3.crontab run $dir/script/updateCpuMemDisk4Db.sh"
echo "    hint1.1 : crontab -e"
echo "    hint1.2 : 0 1 * * * $dir/script/updateCpuMemDisk4Db.sh"
echo "    hint2   : systemctl enable crond"
