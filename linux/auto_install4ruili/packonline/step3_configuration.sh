#!/bin/bash

cd $(dirname $0)
dir_cmd=`pwd`
dir=$dir_cmd
echo "Entering $dir"

cat ./info/title

echo ""
echo "Please configure manually!"
echo ""
echo "DB SERVER : "
echo " 1.MongoDB configuration"
echo "    hint1   : vim rcloud_configuration.properties / deploy.env"
echo "    hint2   : mgd_add_app_user(_force).sh"
echo "    hint3   : mgd_add_admin_user.sh"
echo "    hint4   : vim /etc/mongod.conf"
echo "    hint5   : systemctl enable mongod"
echo "    hint6   : service mongod restart"
echo " 2.MySQL configuration"
echo "    hint1.1 : mysql -u root -p"
echo "    hint1.2 : > SET PASSWORD FOR 'root'@'localhost' = PASSWORD('NEWPASSWD');"
echo "    hint2   : vim /etc/my.cnf"
echo "    hint3   : vim ./script/deploy.env"
echo "    hint4   : mysql_init.sh"
echo "    hint5   : systemctl enable mysqld"
echo " 3.crontab run ./script/updateCpuMemDisk4Db.sh"
echo "    hint1   : if mongodb needs psw, add usr and psw into shell"
echo "    hint2.1 : crontab -e"
echo "    hint3.2 : 0 1 * * * $dir/script/updateCpuMemDisk4Db.sh"
echo "    hint4   : systemctl enable crond"
echo ""
echo "APP SERVER : "
echo " 1.Redis startup when reboot"
echo "    hint1   : systemctl enable redis"
echo " 2.Docker startup when reboot"
echo "    hint1   : systemctl enable docker"
echo " 3.crontab run ./script/updateCpuMemDisk4App.sh"
echo "    hint1.1 : crontab -e"
echo "    hint1.2 : */20 * * * * $dir/script/updateCpuMemDisk4App.sh"
echo "    hint2   : systemctl enable crond"
echo " 4.rcloud_configuration.properties configure"
echo "    hint1   : server.props.addr auto changed by step4_startup.sh"
echo " 5.deploy.env"

