-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: fota_dev_dev
-- ------------------------------------------------------
-- Server version	5.7.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fota_images`
--

DROP TABLE IF EXISTS `fota_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_images` (
  `gid` int(255) NOT NULL AUTO_INCREMENT,
  `firmware_id` varchar(32) NOT NULL,
  `mcu_type` varchar(32) DEFAULT NULL COMMENT '下发的设备类型，单通道，双通道，中央控制器',
  `file_name` varchar(32) DEFAULT NULL COMMENT '固件的文件名',
  `uploader` varchar(32) DEFAULT NULL COMMENT '上传者姓名',
  `uploadertel` varchar(32) DEFAULT NULL COMMENT '上传者手机号',
  `firm_version` varchar(32) DEFAULT NULL COMMENT '固件版本号',
  `content` varchar(255) DEFAULT NULL COMMENT '信息说明',
  `gmtcreate` datetime(6) DEFAULT NULL,
  `gmtupdate` datetime(6) DEFAULT NULL,
  `tenant_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`gid`,`firmware_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_images`
--

LOCK TABLES `fota_images` WRITE;
/*!40000 ALTER TABLE `fota_images` DISABLE KEYS */;
INSERT INTO `fota_images` VALUES (41,'36fe8db92475471b85919703a7062fce','中央控制器','HelloWorld','Sorlcl','13587592960','1.0.0','Upload by SongChaochao','2020-02-23 20:02:24.020000','2020-02-23 20:02:24.020000',NULL);
/*!40000 ALTER TABLE `fota_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_load_history`
--

DROP TABLE IF EXISTS `fota_load_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_load_history` (
  `gid` int(255) NOT NULL AUTO_INCREMENT,
  `imei` varchar(32) DEFAULT NULL,
  `request_id` varchar(32) DEFAULT NULL COMMENT '请求的唯一查询id',
  `firmware_id` varchar(32) DEFAULT NULL,
  `load_process` varchar(255) DEFAULT NULL COMMENT '状态，0无状态，23失败，66成功',
  `config_bo` varchar(1023) DEFAULT NULL COMMENT 'configBO的序列化',
  `gmtcreate` datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `gmtupdate` datetime(6) DEFAULT NULL,
  `gmtmodified` datetime(6) DEFAULT NULL,
  `tenant_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_load_history`
--

LOCK TABLES `fota_load_history` WRITE;
/*!40000 ALTER TABLE `fota_load_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fota_load_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_loaders`
--

DROP TABLE IF EXISTS `fota_loaders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_loaders` (
  `gid` int(255) NOT NULL AUTO_INCREMENT,
  `imei` varchar(32) NOT NULL,
  `imsi` varchar(32) DEFAULT NULL,
  `request_id` varchar(32) DEFAULT NULL COMMENT '用来判断设备升级状态',
  `csq` int(4) DEFAULT NULL,
  `load_status` int(1) DEFAULT NULL,
  `online_status` int(1) DEFAULT NULL,
  `gmtcreate` datetime(6) DEFAULT NULL COMMENT '采集器第一次上线时间',
  `gmtupdate` datetime(6) DEFAULT NULL COMMENT '采集器刷新时间',
  `gmtmodified` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`gid`,`imei`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_loaders`
--

LOCK TABLES `fota_loaders` WRITE;
/*!40000 ALTER TABLE `fota_loaders` DISABLE KEYS */;
/*!40000 ALTER TABLE `fota_loaders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_permission`
--

DROP TABLE IF EXISTS `fota_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_permission` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL COMMENT '菜单编码',
  `p_code` varchar(255) DEFAULT NULL COMMENT '菜单父编码',
  `p_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `is_menu` int(11) DEFAULT NULL COMMENT '是否是菜单 0不是  1是菜单',
  `level` int(11) DEFAULT NULL COMMENT '菜单层级',
  `sort` int(11) DEFAULT NULL COMMENT '菜单排序',
  `status` int(5) DEFAULT NULL COMMENT '状态 0禁用 1启用',
  `gmtcreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmtupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(11) DEFAULT NULL COMMENT '0微信 1PC',
  PRIMARY KEY (`gid`) USING BTREE,
  UNIQUE KEY `FK_CODE` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_permission`
--

LOCK TABLES `fota_permission` WRITE;
/*!40000 ALTER TABLE `fota_permission` DISABLE KEYS */;
INSERT INTO `fota_permission` VALUES (1,'deviceManage/**','/**',0,'设备管理','deviceManage/**',1,1,1,1,'2018-12-24 05:46:51','2019-06-03 01:21:29',1),(2,'uploadOtaFile/**','/**',0,'ota文件管理','uploadOtaFile/**',1,1,5,1,'2018-12-24 05:47:01','2019-06-03 01:21:29',1),(3,'issuanceOtaFile/**','/**',0,'ota下发','issuanceOtaFile/**',1,1,9,1,'2018-12-24 05:47:07','2019-06-03 01:21:29',1),(4,'otaHistory/**','/**',0,'升级历史','otaHistory/**',1,1,11,1,'2018-12-24 05:47:13','2019-06-03 01:21:29',1),(5,'user/**','/**',0,'用户管理','user/**',1,1,20,1,'2020-02-23 13:46:51','2020-02-23 13:46:51',1);
/*!40000 ALTER TABLE `fota_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_role`
--

DROP TABLE IF EXISTS `fota_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_role` (
  `gid` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '角色中文，展示',
  `value` varchar(255) NOT NULL COMMENT '角色英文',
  `info` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` int(1) DEFAULT NULL COMMENT '是否启用',
  `gmtcreate` datetime DEFAULT NULL,
  `gmtupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_role`
--

LOCK TABLES `fota_role` WRITE;
/*!40000 ALTER TABLE `fota_role` DISABLE KEYS */;
INSERT INTO `fota_role` VALUES (3,'设备管理员','DEVICEMANAGE','对设备进行管理',1,'2019-06-01 16:00:19','2019-06-01 16:00:19'),(5,'超级管理员','ADMIN','超级管理员',1,'2019-06-03 01:22:15','2019-06-03 01:22:17');
/*!40000 ALTER TABLE `fota_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_role_permission`
--

DROP TABLE IF EXISTS `fota_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_role_permission` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  `gmtcreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`role_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_role_permission`
--

LOCK TABLES `fota_role_permission` WRITE;
/*!40000 ALTER TABLE `fota_role_permission` DISABLE KEYS */;
INSERT INTO `fota_role_permission` VALUES (3,1,'2019-06-02 17:24:00'),(3,4,'2019-06-02 17:24:01'),(5,1,'2019-06-02 17:22:43'),(5,2,'2019-06-02 17:22:52'),(5,3,'2019-06-02 17:23:05'),(5,4,'2019-06-02 17:23:15'),(5,5,'2020-02-23 13:46:51');
/*!40000 ALTER TABLE `fota_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_users`
--

DROP TABLE IF EXISTS `fota_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_users` (
  `gid` int(64) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `openid` varchar(16) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `realname` varchar(32) DEFAULT NULL,
  `phone` varchar(16) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `status` int(1) DEFAULT NULL COMMENT '是否启用',
  `info` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `lastloginip` varchar(32) DEFAULT NULL COMMENT '上次登陆ip',
  `gmtcreate` datetime DEFAULT NULL,
  `gmtupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`gid`,`username`,`phone`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_users`
--

LOCK TABLES `fota_users` WRITE;
/*!40000 ALTER TABLE `fota_users` DISABLE KEYS */;
INSERT INTO `fota_users` VALUES (16,'Sorlcl',NULL,'82659456','Chenliang','13587592960','Sorl_cl@163.com',1,'技术中心电控',NULL,'2019-07-16 19:40:56','2019-07-16 19:40:56'),(17,'songchaochao',NULL,'songchaochao','Song Chaochao','15658007838','songchaochao@zju.edu.cn',1,'leader',NULL,'2020-02-23 22:06:08','2020-02-23 22:06:08');
/*!40000 ALTER TABLE `fota_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fota_users_role`
--

DROP TABLE IF EXISTS `fota_users_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fota_users_role` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `gmtcreate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fota_users_role`
--

LOCK TABLES `fota_users_role` WRITE;
/*!40000 ALTER TABLE `fota_users_role` DISABLE KEYS */;
INSERT INTO `fota_users_role` VALUES (26,16,5,'2019-07-16 19:40:56'),(28,17,3,'2020-02-23 22:06:08');
/*!40000 ALTER TABLE `fota_users_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_client_details`
--

DROP TABLE IF EXISTS `oauth_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(48) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_client_details`
--

LOCK TABLES `oauth_client_details` WRITE;
/*!40000 ALTER TABLE `oauth_client_details` DISABLE KEYS */;
INSERT INTO `oauth_client_details` VALUES ('app',NULL,'app','app','password,refresh_token',NULL,NULL,NULL,NULL,NULL,NULL),('webApp',NULL,'webApp','app','authorization_code,password,refresh_token,client_credentials',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `oauth_client_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-23 23:07:26
