/*
 Navicat Premium Data Transfer

 Source Server         : ruili
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 3306
 Source Schema         : fota_dev_dev

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/12/2019 20:49:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fota_images
-- ----------------------------
DROP TABLE IF EXISTS `fota_images`;
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
  PRIMARY KEY (`gid`,`firmware_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for fota_load_history
-- ----------------------------
DROP TABLE IF EXISTS `fota_load_history`;
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
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for fota_loaders
-- ----------------------------
DROP TABLE IF EXISTS `fota_loaders`;
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


-- ----------------------------
-- Table structure for fota_permission
-- ----------------------------
DROP TABLE IF EXISTS `fota_permission`;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fota_permission
-- ----------------------------
BEGIN;
INSERT INTO `fota_permission` VALUES (1, 'deviceManage/**', '/**', 0, '设备管理', 'deviceManage/**', 1, 1, 1, 1, '2018-12-24 13:46:51', '2019-06-03 09:21:29', 1);
INSERT INTO `fota_permission` VALUES (2, 'uploadOtaFile/**', '/**', 0, 'ota文件管理', 'uploadOtaFile/**', 1, 1, 5, 1, '2018-12-24 13:47:01', '2019-06-03 09:21:29', 1);
INSERT INTO `fota_permission` VALUES (3, 'issuanceOtaFile/**', '/**', 0, 'ota下发', 'issuanceOtaFile/**', 1, 1, 9, 1, '2018-12-24 13:47:07', '2019-06-03 09:21:29', 1);
INSERT INTO `fota_permission` VALUES (4, 'otaHistory/**', '/**', 0, '升级历史', 'otaHistory/**', 1, 1, 11, 1, '2018-12-24 13:47:13', '2019-06-03 09:21:29', 1);
COMMIT;

-- ----------------------------
-- Table structure for fota_role
-- ----------------------------
DROP TABLE IF EXISTS `fota_role`;
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

-- ----------------------------
-- Records of fota_role
-- ----------------------------
BEGIN;
INSERT INTO `fota_role` VALUES (3, '设备管理员', 'DEVICEMANAGE', '对设备进行管理', 1, '2019-06-01 16:00:19', '2019-06-01 16:00:19');
INSERT INTO `fota_role` VALUES (5, '超级管理员', 'ADMIN', '超级管理员', 1, '2019-06-03 01:22:15', '2019-06-03 01:22:17');
COMMIT;

-- ----------------------------
-- Table structure for fota_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `fota_role_permission`;
CREATE TABLE `fota_role_permission` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  `gmtcreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`role_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fota_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `fota_role_permission` VALUES (3, 1, '2019-06-03 01:24:00');
INSERT INTO `fota_role_permission` VALUES (3, 4, '2019-06-03 01:24:01');
INSERT INTO `fota_role_permission` VALUES (5, 1, '2019-06-03 01:22:43');
INSERT INTO `fota_role_permission` VALUES (5, 2, '2019-06-03 01:22:52');
INSERT INTO `fota_role_permission` VALUES (5, 3, '2019-06-03 01:23:05');
INSERT INTO `fota_role_permission` VALUES (5, 4, '2019-06-03 01:23:15');
COMMIT;

-- ----------------------------
-- Table structure for fota_users
-- ----------------------------
DROP TABLE IF EXISTS `fota_users`;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fota_users
-- ----------------------------
BEGIN;
INSERT INTO `fota_users` VALUES (16, 'Sorlcl', NULL, '82659456', 'Chenliang', '13587592960', 'Sorl_cl@163.com', 1, '技术中心电控', NULL, '2019-07-16 19:40:56', '2019-07-16 19:40:56');
COMMIT;

-- ----------------------------
-- Table structure for fota_users_role
-- ----------------------------
DROP TABLE IF EXISTS `fota_users_role`;
CREATE TABLE `fota_users_role` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `gmtcreate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fota_users_role
-- ----------------------------
BEGIN;
INSERT INTO `fota_users_role` VALUES (26, 16, 5, '2019-07-16 19:40:56');
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
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

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `oauth_client_details` VALUES ('app', NULL, 'app', 'app', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oauth_client_details` VALUES ('webApp', NULL, 'webApp', 'app', 'authorization_code,password,refresh_token,client_credentials', NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
