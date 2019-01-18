/*
 Navicat Premium Data Transfer

 Source Server         : my-cr
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : coderiver_common

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 18/01/2019 18:47:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` bigint(64) NOT NULL COMMENT '评论主键id',
  `pid` bigint(64) DEFAULT NULL COMMENT '父评论id',
  `from_id` bigint(64) NOT NULL COMMENT '评论者id',
  `to_id` bigint(64) NOT NULL COMMENT '被评论者id',
  `content` varchar(512) NOT NULL COMMENT '评论内容',
  `type` int(11) NOT NULL COMMENT '评论的类型：1资源，2项目，3用户',
  `status` int(11) DEFAULT '1' COMMENT '评论状态：1正常，2删除',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `from_id` (`from_id`),
  KEY `to_id` (`to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- ----------------------------
-- Table structure for education_experience
-- ----------------------------
DROP TABLE IF EXISTS `education_experience`;
CREATE TABLE `education_experience` (
  `id` bigint(64) NOT NULL,
  `user_id` bigint(64) NOT NULL COMMENT '用户id',
  `school_name` varchar(64) DEFAULT NULL COMMENT '学校名字',
  `major` varchar(32) DEFAULT NULL COMMENT '专业',
  `degree` varchar(32) DEFAULT NULL COMMENT '学位',
  `comment` varchar(512) DEFAULT NULL COMMENT '备注说明',
  `start_date` bigint(64) DEFAULT NULL COMMENT '开始日期',
  `end_date` bigint(64) DEFAULT NULL COMMENT '结束日期',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态。1正常，2删除',
  `create_time` bigint(64) DEFAULT NULL COMMENT '数据创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  KEY `education_experience_ibfk_1` (`user_id`),
  CONSTRAINT `education_experience_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教育经历';

-- ----------------------------
-- Table structure for project_category
-- ----------------------------
DROP TABLE IF EXISTS `project_category`;
CREATE TABLE `project_category` (
  `id` bigint(64) NOT NULL COMMENT '项目类型id',
  `name` varchar(255) DEFAULT NULL COMMENT '类目类型名称',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目类型表';

-- ----------------------------
-- Table structure for project_info
-- ----------------------------
DROP TABLE IF EXISTS `project_info`;
CREATE TABLE `project_info` (
  `project_id` bigint(64) NOT NULL COMMENT '项目id',
  `project_name` varchar(255) DEFAULT NULL COMMENT '项目名字',
  `project_avatar` varchar(255) DEFAULT NULL COMMENT '项目封面',
  `project_difficulty` float DEFAULT NULL COMMENT '项目难度',
  `category_id` bigint(64) NOT NULL COMMENT '项目类型类目编号',
  `project_status` int(11) DEFAULT '0' COMMENT '项目状态, 0招募中，1 进行中，2已完成，3失败，4延期，5删除',
  `project_introduce` varchar(512) DEFAULT NULL COMMENT '项目简介',
  `project_creator_id` bigint(64) NOT NULL COMMENT '项目创建者id',
  `team_id` bigint(64) DEFAULT NULL COMMENT '项目所属团队id',
  `project_start_date` bigint(64) DEFAULT NULL COMMENT '项目开始时间',
  `project_end_date` bigint(64) DEFAULT NULL COMMENT '项目结束时间',
  `project_delay_date` bigint(64) DEFAULT NULL COMMENT '项目延迟的日期，延迟到几号',
  `delay_count` int(11) DEFAULT NULL COMMENT '项目延期次数。最多三次，每次最多一个月',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`project_id`),
  KEY `project_creator_id` (`project_creator_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `project_info_ibfk_1` FOREIGN KEY (`project_creator_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_info_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `project_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project_like_user
-- ----------------------------
DROP TABLE IF EXISTS `project_like_user`;
CREATE TABLE `project_like_user` (
  `id` bigint(64) NOT NULL COMMENT '主键id',
  `project_id` bigint(64) NOT NULL COMMENT '项目id',
  `user_id` bigint(64) NOT NULL COMMENT '点赞的用户id',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '点赞状态，0 取消点赞，1点赞',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间 ',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `liked_post_id` (`user_id`),
  CONSTRAINT `project_like_user_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project_info` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for project_picture
-- ----------------------------
DROP TABLE IF EXISTS `project_picture`;
CREATE TABLE `project_picture` (
  `id` bigint(64) NOT NULL COMMENT '图片id',
  `project_id` bigint(64) NOT NULL COMMENT '项目id',
  `picture_url` varchar(255) NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_picture_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project_info` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目截图';

-- ----------------------------
-- Table structure for team_application
-- ----------------------------
DROP TABLE IF EXISTS `team_application`;
CREATE TABLE `team_application` (
  `id` bigint(64) NOT NULL,
  `project_id` bigint(64) DEFAULT NULL COMMENT '申请加入的项目id',
  `team_id` bigint(64) DEFAULT NULL COMMENT '申请加入的团队id',
  `target_user_id` bigint(64) NOT NULL COMMENT '目标用户id。如果是用户主动申请，就是申请者id；如果是被邀请，就是被邀请者id。',
  `creator_user_id` bigint(64) NOT NULL COMMENT '申请创建者id。如果是用户主动申请，target_user_id 和 creator_user_id 都是该申请者id；如果是被邀请，creator_user_id 是邀请者id。',
  `role_id_apply` bigint(64) NOT NULL COMMENT '申请在本项目中的角色id',
  `workday_start_time` time DEFAULT NULL COMMENT '工作日空闲开始时间',
  `workday_end_time` time DEFAULT NULL COMMENT '工作日空闲结束时间',
  `weekend_start_time` time DEFAULT NULL COMMENT '周末空闲开始时间',
  `weekend_end_time` time DEFAULT NULL COMMENT '周末空闲结束时间',
  `comments` varchar(512) DEFAULT NULL COMMENT '申请备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态。1待审核，2通过，3驳回，4撤回，5删除',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`,`status`) USING BTREE,
  KEY `project_id` (`project_id`),
  KEY `role_id_apply` (`role_id_apply`),
  KEY `team_id` (`team_id`),
  KEY `team_application_ibfk_3` (`target_user_id`),
  CONSTRAINT `team_application_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project_info` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `team_application_ibfk_3` FOREIGN KEY (`target_user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组队申请表。可以申请加入项目或团队，可以自己申请加入也可以邀请';

-- ----------------------------
-- Table structure for team_info
-- ----------------------------
DROP TABLE IF EXISTS `team_info`;
CREATE TABLE `team_info` (
  `team_id` bigint(64) NOT NULL COMMENT '团队id',
  `team_name` varchar(255) DEFAULT NULL COMMENT '团队名称',
  `team_avatar` varchar(255) DEFAULT NULL COMMENT '团队logo',
  `team_introduce` varchar(512) DEFAULT NULL COMMENT '团队介绍',
  `team_creator_id` bigint(64) NOT NULL COMMENT '团队创建者id',
  `description` varchar(128) DEFAULT NULL COMMENT '描述',
  `status` int(11) DEFAULT '1' COMMENT '状态。1正常，2解散',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`team_id`),
  KEY `team_creator_id` (`team_creator_id`),
  CONSTRAINT `team_info_ibfk_1` FOREIGN KEY (`team_creator_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='团队信息表';

-- ----------------------------
-- Table structure for user_experience
-- ----------------------------
DROP TABLE IF EXISTS `user_experience`;
CREATE TABLE `user_experience` (
  `id` bigint(64) NOT NULL COMMENT '工作经验id',
  `name` varchar(64) DEFAULT NULL COMMENT '工作经验名称',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` bigint(64) NOT NULL COMMENT '用户id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `gender` int(11) DEFAULT '0' COMMENT '性别：0未知, 1男, 2女',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `city` bigint(64) DEFAULT NULL COMMENT '城市id',
  `role_id` bigint(64) DEFAULT NULL COMMENT '角色id',
  `experience_id` bigint(64) DEFAULT NULL COMMENT '工作经验id',
  `workday_start_time` time DEFAULT NULL COMMENT '工作日空闲开始时间',
  `workday_end_time` time DEFAULT NULL COMMENT '工作日空闲结束时间',
  `weekend_start_time` time DEFAULT NULL COMMENT '周末空闲开始时间',
  `weekend_end_time` time DEFAULT NULL COMMENT '周末空闲结束时间',
  `influence` int(11) DEFAULT NULL COMMENT '影响力',
  `introduce` varchar(512) DEFAULT NULL COMMENT '个人简介',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态：1正常 2冻结 3注销',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `id` (`user_id`) USING HASH,
  KEY `user_info_ibfk_1` (`role_id`),
  KEY `experience_id` (`experience_id`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_info_ibfk_2` FOREIGN KEY (`experience_id`) REFERENCES `user_experience` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_like
-- ----------------------------
DROP TABLE IF EXISTS `user_like`;
CREATE TABLE `user_like` (
  `id` bigint(64) NOT NULL COMMENT '主键id',
  `liked_user_id` bigint(64) NOT NULL COMMENT '被点赞的用户id',
  `liked_post_id` bigint(64) NOT NULL COMMENT '点赞的用户id',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '点赞状态，1 点赞，2取消',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `liked_user_id` (`liked_user_id`),
  KEY `liked_post_id` (`liked_post_id`),
  CONSTRAINT `user_like_ibfk_1` FOREIGN KEY (`liked_user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_like_ibfk_2` FOREIGN KEY (`liked_post_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户点赞表';

-- ----------------------------
-- Table structure for user_login
-- ----------------------------
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE `user_login` (
  `id` bigint(64) NOT NULL,
  `user_id` bigint(64) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `email_active` int(11) DEFAULT '0',
  `phone` varchar(64) DEFAULT NULL,
  `phone_active` int(11) DEFAULT '0',
  `wechat_id` varchar(255) DEFAULT NULL,
  `wechat_active` int(11) DEFAULT '0',
  `sina_id` varchar(255) DEFAULT NULL,
  `sina_active` int(11) DEFAULT '0',
  `github_id` varchar(255) DEFAULT NULL,
  `github_active` int(11) DEFAULT '0',
  `create_time` bigint(64) DEFAULT NULL,
  `update_time` bigint(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_login_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for user_project_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_project_relation`;
CREATE TABLE `user_project_relation` (
  `id` bigint(64) NOT NULL,
  `project_id` bigint(64) NOT NULL COMMENT '项目id',
  `role_id_project` bigint(64) NOT NULL COMMENT '用户在本项目的角色',
  `user_id` bigint(64) NOT NULL COMMENT '用户id',
  `status` int(11) DEFAULT '0' COMMENT '当前状态，0未匹配，1已匹配',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id_project` (`role_id_project`),
  CONSTRAINT `user_project_relation_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project_info` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_project_relation_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目成员表';

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(64) NOT NULL COMMENT '角色id',
  `name` varchar(64) DEFAULT NULL COMMENT '角色名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色表';

-- ----------------------------
-- Table structure for user_team_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_team_relation`;
CREATE TABLE `user_team_relation` (
  `id` bigint(64) NOT NULL,
  `user_id` bigint(64) NOT NULL COMMENT '用户id',
  `team_id` bigint(64) NOT NULL COMMENT '团队id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `user_team_relation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_team_relation_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team_info` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for work_experience
-- ----------------------------
DROP TABLE IF EXISTS `work_experience`;
CREATE TABLE `work_experience` (
  `id` bigint(64) NOT NULL,
  `user_id` bigint(64) NOT NULL,
  `company_name` varchar(64) DEFAULT NULL COMMENT '公司名字',
  `position` varchar(32) DEFAULT NULL COMMENT '职位',
  `comment` varchar(512) DEFAULT NULL COMMENT '备注',
  `start_date` bigint(64) DEFAULT NULL COMMENT '开始日期',
  `end_date` bigint(64) DEFAULT NULL COMMENT '结束日期',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态。1正常，2删除',
  `create_time` bigint(64) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(64) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `work_experience_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工作经历';

SET FOREIGN_KEY_CHECKS = 1;
