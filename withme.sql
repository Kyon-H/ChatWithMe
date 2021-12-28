/*
Navicat MySQL Data Transfer

Source Server         : Mysql
Source Server Version : 50735
Source Host           : localhost:3306
Source Database       : withme

Target Server Type    : MYSQL
Target Server Version : 50735
File Encoding         : 65001

Date: 2021-12-28 20:54:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for group_main
-- ----------------------------
DROP TABLE IF EXISTS `group_main`;
CREATE TABLE `group_main` (
  `id` int(11) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `group_name` varchar(20) NOT NULL,
  `group_creater_id` int(11) NOT NULL,
  `group_create_time` datetime NOT NULL,
  `group_introduction` varchar(50) DEFAULT NULL,
  `group_user_count` int(11) NOT NULL,
  `group_members` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`),
  KEY `group_creater_id` (`group_creater_id`),
  CONSTRAINT `group_main_ibfk_1` FOREIGN KEY (`group_creater_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_main
-- ----------------------------
INSERT INTO `group_main` VALUES ('1', '87032', 'javaweb', '1', '2021-11-26 03:58:30', '大作业', '3', '1,1,2,4');
INSERT INTO `group_main` VALUES ('2', '86327', '第n组', '2', '2021-12-22 05:11:21', 'Javaweb 测试群', '1', '2,2');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `content` varchar(5000) NOT NULL,
  `type` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `is_transport` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`to_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`to_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '2', '1', '我是123', '5', '2021-11-26 03:56:48', '1');
INSERT INTO `message` VALUES ('2', '1', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-11-26 03:56:56', '1');
INSERT INTO `message` VALUES ('3', '1', '2', '你好', '0', '2021-11-26 03:57:36', '1');
INSERT INTO `message` VALUES ('4', '2', '1', '你好！', '0', '2021-11-26 03:57:47', '1');
INSERT INTO `message` VALUES ('5', '2', '1', '上线通知', '3', '2021-11-26 03:58:03', '1');
INSERT INTO `message` VALUES ('6', '1', '2', '1', '6', '2021-11-26 03:58:48', '1');
INSERT INTO `message` VALUES ('7', '2', '1', '日日日日日', '2', '2021-11-26 03:59:14', '1');
INSERT INTO `message` VALUES ('8', '2', '1', '日日日日日', '1', '2021-11-26 03:59:14', '1');
INSERT INTO `message` VALUES ('9', '2', '2', '日日日日日', '1', '2021-11-26 03:59:14', '1');
INSERT INTO `message` VALUES ('10', '1', '1', '那你', '2', '2021-11-26 03:59:26', '1');
INSERT INTO `message` VALUES ('11', '1', '1', '那你', '1', '2021-11-26 03:59:26', '1');
INSERT INTO `message` VALUES ('12', '1', '2', '那你', '1', '2021-11-26 03:59:26', '1');
INSERT INTO `message` VALUES ('13', '1', '1', '1', '2', '2021-11-26 04:03:24', '1');
INSERT INTO `message` VALUES ('14', '1', '1', '1', '1', '2021-11-26 04:03:24', '1');
INSERT INTO `message` VALUES ('15', '1', '2', '1', '1', '2021-11-26 04:03:24', '1');
INSERT INTO `message` VALUES ('16', '2', '1', '2', '2', '2021-11-26 04:03:34', '1');
INSERT INTO `message` VALUES ('17', '2', '1', '2', '1', '2021-11-26 04:03:34', '1');
INSERT INTO `message` VALUES ('18', '2', '2', '2', '1', '2021-11-26 04:03:34', '1');
INSERT INTO `message` VALUES ('19', '2', '1', '3', '2', '2021-11-26 04:03:42', '1');
INSERT INTO `message` VALUES ('20', '2', '1', '3', '1', '2021-11-26 04:03:42', '1');
INSERT INTO `message` VALUES ('21', '2', '2', '3', '1', '2021-11-26 04:03:42', '1');
INSERT INTO `message` VALUES ('22', '1', '1', '', '5', '2021-11-26 04:08:26', '1');
INSERT INTO `message` VALUES ('23', '1', '1', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-11-26 04:08:57', '1');
INSERT INTO `message` VALUES ('24', '1', '1', '不', '0', '2021-11-26 04:09:19', '1');
INSERT INTO `message` VALUES ('25', '1', '1', '上线通知', '3', '2021-11-26 04:32:20', '1');
INSERT INTO `message` VALUES ('26', '1', '1', 'a', '0', '2021-11-26 04:32:36', '1');
INSERT INTO `message` VALUES ('27', '1', '1', '上线通知', '3', '2021-11-29 01:15:13', '1');
INSERT INTO `message` VALUES ('28', '1', '1', '上线通知', '3', '2021-11-29 01:19:40', '1');
INSERT INTO `message` VALUES ('29', '1', '1', '上线通知', '3', '2021-11-29 01:22:20', '1');
INSERT INTO `message` VALUES ('30', '1', '1', '上线通知', '3', '2021-11-29 01:23:58', '1');
INSERT INTO `message` VALUES ('31', '1', '2', '123', '0', '2021-11-29 02:36:05', '1');
INSERT INTO `message` VALUES ('32', '1', '3', '啊啊啊', '0', '2021-11-29 02:36:16', '1');
INSERT INTO `message` VALUES ('33', '1', '3', '', '5', '2021-11-29 02:46:14', '1');
INSERT INTO `message` VALUES ('34', '3', '1', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-11-30 08:59:23', '1');
INSERT INTO `message` VALUES ('36', '2', '3', '11', '0', '2021-12-07 21:31:30', '1');
INSERT INTO `message` VALUES ('37', '2', '1', '22', '0', '2021-12-07 21:31:33', '1');
INSERT INTO `message` VALUES ('38', '2', '1', '223', '0', '2021-12-08 02:21:30', '1');
INSERT INTO `message` VALUES ('40', '2', '3', '<p>12</p>', '0', '2021-12-08 21:48:14', '1');
INSERT INTO `message` VALUES ('41', '2', '3', '<p>12<img src=\"http://img.baidu.com/hi/jx2/j_0001.gif\"/></p>', '0', '2021-12-08 21:48:34', '1');
INSERT INTO `message` VALUES ('42', '2', '3', '<p>a<img src=\"http://img.baidu.com/hi/jx2/j_0067.gif\"/></p>', '0', '2021-12-08 21:52:05', '1');
INSERT INTO `message` VALUES ('43', '2', '3', '12', '0', '2021-12-08 21:53:44', '1');
INSERT INTO `message` VALUES ('44', '2', '3', '34', '0', '2021-12-08 21:54:17', '1');
INSERT INTO `message` VALUES ('45', '2', '3', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0007.gif\"/></p>', '0', '2021-12-08 21:58:09', '1');
INSERT INTO `message` VALUES ('46', '2', '1', '<p><strong>哈</strong><br/></p>', '0', '2021-12-08 23:38:36', '1');
INSERT INTO `message` VALUES ('47', '2', '1', '<p>2</p>', '0', '2021-12-09 00:22:03', '1');
INSERT INTO `message` VALUES ('48', '2', '1', '<p>3</p>', '0', '2021-12-09 00:29:57', '1');
INSERT INTO `message` VALUES ('49', '2', '1', '<p>4</p>', '0', '2021-12-09 00:32:42', '1');
INSERT INTO `message` VALUES ('50', '2', '1', '<p>5</p>', '0', '2021-12-09 00:34:48', '1');
INSERT INTO `message` VALUES ('51', '2', '1', '<p>6</p>', '0', '2021-12-09 00:36:11', '1');
INSERT INTO `message` VALUES ('52', '2', '1', '<p>7</p>', '0', '2021-12-09 00:36:58', '1');
INSERT INTO `message` VALUES ('53', '2', '1', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0068.gif\"/></p>', '0', '2021-12-09 00:37:02', '1');
INSERT INTO `message` VALUES ('54', '2', '1', '<p><a href=\"http://www.baidu.com\" target=\"_self\">百度</a><br/></p>', '0', '2021-12-09 00:38:14', '1');
INSERT INTO `message` VALUES ('55', '2', '1', '<p>12</p>', '0', '2021-12-09 01:20:43', '1');
INSERT INTO `message` VALUES ('56', '2', '1', '<p>zai</p>', '2', '2021-12-09 01:20:51', '1');
INSERT INTO `message` VALUES ('57', '2', '1', '<p>zai</p>', '1', '2021-12-09 01:20:51', '1');
INSERT INTO `message` VALUES ('58', '2', '2', '<p>zai</p>', '1', '2021-12-09 01:20:51', '1');
INSERT INTO `message` VALUES ('59', '2', '1', '', '5', '2021-12-09 01:21:53', '1');
INSERT INTO `message` VALUES ('60', '2', '1', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0023.gif\"/></p>', '2', '2021-12-09 01:25:32', '1');
INSERT INTO `message` VALUES ('61', '2', '1', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0023.gif\"/></p>', '1', '2021-12-09 01:25:32', '1');
INSERT INTO `message` VALUES ('62', '2', '2', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0023.gif\"/></p>', '1', '2021-12-09 01:25:32', '1');
INSERT INTO `message` VALUES ('63', '2', '1', '<p><a href=\"http://www.baidu.com\">www.baidu.com</a></p>', '0', '2021-12-09 02:24:57', '1');
INSERT INTO `message` VALUES ('64', '2', '1', '<p><a href=\"http://www.bilibili.com\">www.bilibili.com</a> </p><p><br/></p>', '0', '2021-12-09 02:25:57', '1');
INSERT INTO `message` VALUES ('67', '2', '1', '<p><img src=\"ueditor/../../Upload/chatchat/image/20211211/1639217173108013162.png\" title=\"1639217173108013162.png\" alt=\"iscollect.png\"/></p>', '0', '2021-12-11 04:06:26', '1');
INSERT INTO `message` VALUES ('68', '2', '1', '<p><img src=\"ueditor/../../Upload/chatchat/image/20211211/1639217318550041828.png\" title=\"1639217318550041828.png\" alt=\"通知.png\"/></p>', '0', '2021-12-11 04:08:39', '1');
INSERT INTO `message` VALUES ('76', '2', '1', '<p><img src=\"ueditor/../../Upload/chatchat/image/20211211/1639223541035027403.jpg\" title=\"1639223541035027403.jpg\" alt=\"1912080045.jpg\"/></p>', '0', '2021-12-11 05:52:22', '1');
INSERT INTO `message` VALUES ('77', '2', '1', '<p><img src=\"ueditor/../../Upload/chatchat/image/20211211/1639223584797044731.png\" title=\"1639223584797044731.png\" alt=\"IMG_0212.png\"/></p>', '0', '2021-12-11 05:53:05', '1');
INSERT INTO `message` VALUES ('83', '2', '1', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0067.gif\"/></p>', '0', '2021-12-11 06:30:36', '1');
INSERT INTO `message` VALUES ('85', '1', '2', 'shenqing', '-1', '2021-12-14 02:34:53', '1');
INSERT INTO `message` VALUES ('94', '2', '1', '<table><tbody><tr class=\"firstRow\"><td width=\"95\" valign=\"top\" style=\"word-break: break-all;\">1</td><td width=\"95\" valign=\"top\" style=\"word-break: break-all;\">2</td><td width=\"95\" valign=\"top\" style=\"word-break: break-all;\">3</td><td width=\"95\" valign=\"top\" style=\"word-break: break-all;\">4</td><td width=\"95\" valign=\"top\" style=\"word-break: break-all;\">5</td></tr><tr><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td></tr><tr><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td></tr><tr><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td></tr><tr><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td><td width=\"95\" valign=\"top\"><br/></td></tr></tbody></table><p><br/></p>', '0', '2021-12-20 21:33:20', '1');
INSERT INTO `message` VALUES ('95', '4', '2', '2021', '5', '2021-12-23 18:41:13', '1');
INSERT INTO `message` VALUES ('96', '2', '4', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-23 18:41:30', '1');
INSERT INTO `message` VALUES ('100', '2', '1', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0078.gif\"/></p>', '0', '2021-12-24 03:44:54', '1');
INSERT INTO `message` VALUES ('101', '2', '4', '<p><img src=\"/../Upload/ChatWithMe/image/20211224/1640339431325036126.jpg\" title=\"1640339431325036126.jpg\" alt=\"mine.jpg\"/></p>', '0', '2021-12-24 03:50:33', '1');
INSERT INTO `message` VALUES ('102', '4', '2', '<p>米好</p>', '0', '2021-12-25 23:51:07', '1');
INSERT INTO `message` VALUES ('103', '2', '1', '<p>hha</p>', '2', '2021-12-26 00:17:37', '1');
INSERT INTO `message` VALUES ('104', '2', '1', '<p>hha</p>', '1', '2021-12-26 00:17:37', '1');
INSERT INTO `message` VALUES ('105', '2', '2', '<p>hha</p>', '1', '2021-12-26 00:17:37', '1');
INSERT INTO `message` VALUES ('106', '2', '1', '<p>1</p>', '0', '2021-12-26 00:22:19', '1');
INSERT INTO `message` VALUES ('107', '2', '1', '<p>2</p>', '0', '2021-12-26 00:29:26', '1');
INSERT INTO `message` VALUES ('108', '2', '4', '<p>3</p>', '0', '2021-12-26 00:29:34', '1');
INSERT INTO `message` VALUES ('109', '2', '1', '<p>12</p>', '2', '2021-12-26 00:29:41', '1');
INSERT INTO `message` VALUES ('110', '2', '1', '<p>12</p>', '1', '2021-12-26 00:29:41', '1');
INSERT INTO `message` VALUES ('111', '2', '2', '<p>12</p>', '1', '2021-12-26 00:29:41', '1');
INSERT INTO `message` VALUES ('112', '2', '1', '<p>23</p>', '2', '2021-12-26 00:29:45', '1');
INSERT INTO `message` VALUES ('113', '2', '1', '<p>23</p>', '1', '2021-12-26 00:29:45', '1');
INSERT INTO `message` VALUES ('114', '2', '2', '<p>23</p>', '1', '2021-12-26 00:29:45', '1');
INSERT INTO `message` VALUES ('115', '2', '1', '<p>q</p>', '2', '2021-12-26 00:30:31', '1');
INSERT INTO `message` VALUES ('116', '2', '1', '<p>q</p>', '1', '2021-12-26 00:30:31', '1');
INSERT INTO `message` VALUES ('117', '2', '2', '<p>q</p>', '1', '2021-12-26 00:30:31', '1');
INSERT INTO `message` VALUES ('118', '2', '2', '<p>哦哦哦哦哦哦</p>', '2', '2021-12-26 00:47:08', '1');
INSERT INTO `message` VALUES ('119', '2', '2', '<p>哦哦哦哦哦哦</p>', '1', '2021-12-26 00:47:08', '1');
INSERT INTO `message` VALUES ('120', '2', '4', '<p>哦哦哦哦哦</p>', '0', '2021-12-26 00:47:45', '1');
INSERT INTO `message` VALUES ('121', '2', '1', '<p><video class=\"edui-upload-video  vjs-default-skin video-js\" controls=\"\" preload=\"none\" width=\"420\" height=\"280\" src=\"/../Upload/ChatWithMe/video/20211226/1640525297490029956.ogv\" data-setup=\"{}\"></video></p>', '0', '2021-12-26 07:28:22', '1');
INSERT INTO `message` VALUES ('122', '2', '4', '1', '6', '2021-12-26 08:28:57', '1');
INSERT INTO `message` VALUES ('123', '4', '2', '上线通知', '3', '2021-12-26 08:29:45', '1');
INSERT INTO `message` VALUES ('124', '4', '2', '上线通知', '3', '2021-12-26 08:29:51', '1');
INSERT INTO `message` VALUES ('125', '4', '1', '<p>2021 第一次进群</p>', '2', '2021-12-26 08:30:21', '1');
INSERT INTO `message` VALUES ('126', '4', '1', '<p>2021 第一次进群</p>', '1', '2021-12-26 08:30:21', '1');
INSERT INTO `message` VALUES ('127', '4', '2', '<p>2021 第一次进群</p>', '1', '2021-12-26 08:30:21', '1');
INSERT INTO `message` VALUES ('128', '4', '4', '<p>2021 第一次进群</p>', '1', '2021-12-26 08:30:21', '1');
INSERT INTO `message` VALUES ('129', '2', '4', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0067.gif\"/></p>', '0', '2021-12-27 06:59:02', '1');
INSERT INTO `message` VALUES ('130', '2', '4', '<p><img src=\"/../Upload/ChatWithMe/image/20211227/1640609950127033505.png\" title=\"1640609950127033505.png\" alt=\"通知.png\"/></p>', '0', '2021-12-27 06:59:11', '1');
INSERT INTO `message` VALUES ('131', '2', '4', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0071.gif\"/></p>', '0', '2021-12-27 06:59:23', '1');
INSERT INTO `message` VALUES ('132', '2', '5', '我是电脑', '5', '2021-12-27 08:52:56', '1');
INSERT INTO `message` VALUES ('133', '2', '5', '133', '5', '2021-12-27 08:57:57', '1');
INSERT INTO `message` VALUES ('134', '2', '3', 'test', '5', '2021-12-27 09:00:43', '1');
INSERT INTO `message` VALUES ('135', '3', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 09:00:52', '1');
INSERT INTO `message` VALUES ('136', '3', '2', '上线通知', '3', '2021-12-27 09:00:56', '1');
INSERT INTO `message` VALUES ('137', '2', '5', '我是电脑', '5', '2021-12-27 09:35:54', '1');
INSERT INTO `message` VALUES ('138', '2', '3', '123', '5', '2021-12-27 10:21:53', '1');
INSERT INTO `message` VALUES ('139', '2', '3', '123 2 test', '5', '2021-12-27 10:22:42', '1');
INSERT INTO `message` VALUES ('140', '3', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 10:23:03', '1');
INSERT INTO `message` VALUES ('141', '2', '5', 'wsdn', '5', '2021-12-27 10:27:30', '1');
INSERT INTO `message` VALUES ('142', '5', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 10:28:21', '1');
INSERT INTO `message` VALUES ('143', '5', '2', '', '-1', '2021-12-27 10:28:26', '1');
INSERT INTO `message` VALUES ('144', '5', '2', '', '-1', '2021-12-27 10:28:27', '1');
INSERT INTO `message` VALUES ('145', '5', '2', '系统抛了一枚硬币，觉得你俩不合适，所以驳回了你的申请。', '-1', '2021-12-27 10:28:29', '1');
INSERT INTO `message` VALUES ('146', '2', '5', '五十多年', '5', '2021-12-27 10:29:08', '1');
INSERT INTO `message` VALUES ('147', '5', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 10:29:16', '1');
INSERT INTO `message` VALUES ('148', '5', '2', 'iphone to 123', '5', '2021-12-27 18:08:17', '1');
INSERT INTO `message` VALUES ('149', '2', '5', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 18:08:22', '1');
INSERT INTO `message` VALUES ('150', '2', '1', '刘鑫昌 2 123', '5', '2021-12-27 18:09:08', '1');
INSERT INTO `message` VALUES ('151', '1', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 18:09:31', '1');
INSERT INTO `message` VALUES ('152', '2', '4', '123 to 2021', '5', '2021-12-27 18:10:13', '1');
INSERT INTO `message` VALUES ('153', '4', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 18:10:26', '1');
INSERT INTO `message` VALUES ('154', '2', '3', '123 to test', '5', '2021-12-27 18:19:34', '1');
INSERT INTO `message` VALUES ('155', '3', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 18:19:50', '1');
INSERT INTO `message` VALUES ('156', '3', '2', '上线通知', '3', '2021-12-27 18:19:51', '1');
INSERT INTO `message` VALUES ('157', '2', '4', '123 to 2021', '5', '2021-12-27 18:23:37', '1');
INSERT INTO `message` VALUES ('158', '4', '2', '我已经同意了你的好友申请，快一起来搞点事情吧！', '-1', '2021-12-27 18:23:53', '1');
INSERT INTO `message` VALUES ('159', '2', '1', '<p><strong>你好</strong><br/></p>', '0', '2021-12-27 18:54:04', '1');
INSERT INTO `message` VALUES ('160', '1', '2', '上线通知', '3', '2021-12-27 18:54:29', '1');
INSERT INTO `message` VALUES ('161', '1', '2', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0071.gif\"/></p>', '0', '2021-12-27 18:54:52', '1');
INSERT INTO `message` VALUES ('162', '2', '1', '<p><img src=\"/../Upload/ChatWithMe/image/20211228/1640653167407068875.jpg\" title=\"1640653167407068875.jpg\" alt=\"blackrookshooter.jpg\"/></p>', '0', '2021-12-27 18:59:29', '0');
INSERT INTO `message` VALUES ('163', '2', '1', '<p><a href=\"http://www.bilibili.com\">www.bilibili.com</a>&nbsp;</p>', '0', '2021-12-27 18:59:44', '0');
INSERT INTO `message` VALUES ('164', '2', '4', '<p><img src=\"http://img.baidu.com/hi/jx2/j_0079.gif\"/></p>', '0', '2021-12-28 06:41:53', '0');
INSERT INTO `message` VALUES ('165', '2', '3', '<p><img src=\"/../Upload/ChatWithMe/image/20211228/1640695458927015110.png\" title=\"1640695458927015110.png\" alt=\"拓扑图.png\"/></p>', '0', '2021-12-28 06:44:19', '0');

-- ----------------------------
-- Table structure for user_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE `user_detail` (
  `user_detail_id` int(11) NOT NULL,
  `user_detail_name` varchar(20) NOT NULL,
  `user_detail_nickname` varchar(20) NOT NULL,
  `user_detail_password` varchar(20) NOT NULL,
  `user_detail_role` int(11) NOT NULL,
  `user_mail_number` varchar(30) DEFAULT NULL,
  `user_phone_number` varchar(20) DEFAULT NULL,
  `user_register_time` datetime NOT NULL,
  PRIMARY KEY (`user_detail_id`),
  UNIQUE KEY `user_detail_name` (`user_detail_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_detail
-- ----------------------------
INSERT INTO `user_detail` VALUES ('1', '刘鑫昌', 'Kyon', 'lxclxc', '0', 'lxc123@qq.com', '15138694662', '2021-11-26 03:54:56');
INSERT INTO `user_detail` VALUES ('2', '123', '123', '123123', '0', '1234@qq.com', '15138694661', '2021-11-26 03:56:00');
INSERT INTO `user_detail` VALUES ('3', 'test', 'auser', 'testtest', '0', '', '', '2021-11-27 01:31:56');
INSERT INTO `user_detail` VALUES ('4', '2021', '2021', '202111', '0', '', '', '2021-12-23 18:40:27');
INSERT INTO `user_detail` VALUES ('5', 'iphone', '手机', '123456', '0', '', '', '2021-12-27 08:33:35');
INSERT INTO `user_detail` VALUES ('6', '1912080128', 'lg', '12345678', '0', '', '', '2021-12-27 18:06:38');

-- ----------------------------
-- Table structure for user_group_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_group_relation`;
CREATE TABLE `user_group_relation` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `group_level` int(11) NOT NULL,
  `group_user_nickname` varchar(20) NOT NULL,
  `enter_group_time` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `user_group_relation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `user_group_relation_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group_main` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_group_relation
-- ----------------------------
INSERT INTO `user_group_relation` VALUES ('1', '1', '10', 'Kyon', '2021-11-26 03:58:30');
INSERT INTO `user_group_relation` VALUES ('2', '1', '0', '123', '2021-11-26 03:58:55');
INSERT INTO `user_group_relation` VALUES ('2', '2', '10', '123', '2021-12-22 05:11:21');
INSERT INTO `user_group_relation` VALUES ('4', '1', '0', '2021', '2021-12-26 08:29:51');

-- ----------------------------
-- Table structure for user_image
-- ----------------------------
DROP TABLE IF EXISTS `user_image`;
CREATE TABLE `user_image` (
  `user_id` int(11) NOT NULL,
  `user_img` varchar(500) DEFAULT NULL COMMENT '用户头像',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_image_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_detail` (`user_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_image
-- ----------------------------
INSERT INTO `user_image` VALUES ('1', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/1/1640489751495.jpg');
INSERT INTO `user_image` VALUES ('2', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/2/1640653279022.jpg');
INSERT INTO `user_image` VALUES ('3', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/default/photo.jpg');
INSERT INTO `user_image` VALUES ('4', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/4/1640498366180.jpg');
INSERT INTO `user_image` VALUES ('5', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/5/1640619767304.png');
INSERT INTO `user_image` VALUES ('6', 'http://ulsxecrimg.oss-cn-beijing.aliyuncs.com/userheadimg/default/photo.jpg');

-- ----------------------------
-- Table structure for user_main
-- ----------------------------
DROP TABLE IF EXISTS `user_main`;
CREATE TABLE `user_main` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_nickname` varchar(20) DEFAULT NULL,
  `user_is_online` int(11) NOT NULL,
  `user_role` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  CONSTRAINT `user_main_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_detail` (`user_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_main
-- ----------------------------
INSERT INTO `user_main` VALUES ('1', '刘鑫昌', 'Kyon', '0', '0');
INSERT INTO `user_main` VALUES ('2', '123', '123', '0', '0');
INSERT INTO `user_main` VALUES ('3', 'test', 'auser', '0', '0');
INSERT INTO `user_main` VALUES ('4', '2021', '2021', '0', '0');
INSERT INTO `user_main` VALUES ('5', 'iphone', '手机', '0', '0');
INSERT INTO `user_main` VALUES ('6', '1912080128', 'lg', '0', '0');

-- ----------------------------
-- Table structure for user_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_relation`;
CREATE TABLE `user_relation` (
  `user_id_a` int(11) NOT NULL,
  `user_id_b` int(11) NOT NULL,
  `relation_status` int(11) NOT NULL,
  `relation_start` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id_a`,`user_id_b`),
  KEY `user_id_b` (`user_id_b`),
  CONSTRAINT `user_relation_ibfk_1` FOREIGN KEY (`user_id_a`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `user_relation_ibfk_2` FOREIGN KEY (`user_id_b`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_relation
-- ----------------------------
INSERT INTO `user_relation` VALUES ('1', '3', '1', '2021-11-30 08:59:24');
INSERT INTO `user_relation` VALUES ('2', '3', '1', '2021-12-27 18:19:51');
INSERT INTO `user_relation` VALUES ('2', '4', '1', '2021-12-27 18:23:53');
