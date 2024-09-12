/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50528
 Source Host           : localhost:3306
 Source Schema         : warehouse_manager

 Target Server Type    : MySQL
 Target Server Version : 50528
 File Encoding         : 65001

 Date: 12/09/2024 09:07:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention`  (
                              `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                              `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货名',
                              `storage` int(11) NOT NULL COMMENT '仓库',
                              `goodsType` int(11) NOT NULL COMMENT '分类',
                              `count` int(11) NULL DEFAULT NULL COMMENT '数量',
                              `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of attention
-- ----------------------------
INSERT INTO `attention` VALUES (1, 'iPhone14', 2, 2, 85, '货物缺少');
INSERT INTO `attention` VALUES (2, 'a56', 3, 3, 1100, '货物滞销');


-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
                          `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                          `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货名',
                          `storage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌',
                          `goodstype` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内存',
                          `count` int(11) NULL DEFAULT NULL COMMENT '数量',
                          `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 'iPhone14', '2', '5', 70, '白色');
INSERT INTO `goods` VALUES (4, '小米13', '3', '3', 247, '紫色');
INSERT INTO `goods` VALUES (5, 'Reno7', '4', '5', 500, '绿色');
INSERT INTO `goods` VALUES (6, 'a56', '4', '3', 1100, '黑色');
INSERT INTO `goods` VALUES (7, 'iPhone15', '2', '4', 500, '请勿淋湿');
INSERT INTO `goods` VALUES (8, 'iPhone11', '2', '3', 400, '请勿淋湿');
INSERT INTO `goods` VALUES (11, 'Reno6', '4', '2', 800, '请勿淋湿');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
                              `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                              `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内存分类',
                              `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (1, '64G', '红色');
INSERT INTO `goodstype` VALUES (2, '128G', '紫色');
INSERT INTO `goodstype` VALUES (3, '256G', '绿色');
INSERT INTO `goodstype` VALUES (4, '512G', '黑色');
INSERT INTO `goodstype` VALUES (5, '1TB', '红色');
INSERT INTO `goodstype` VALUES (6, '32G', '粉色');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
                         `id` int(11) NOT NULL COMMENT '主键',
                         `menuCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单编码',
                         `menuName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名字',
                         `menuLevel` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单级别',
                         `menuParentCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单的父code',
                         `menuClick` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '点击触发的函数',
                         `menuRight` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限 0超级管理员，1表示管理员，2表示普通用户，可以用逗号组合使用',
                         `menuComponent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应Vue菜单组件',
                         `menuIcon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '001', '管理员信息管理', '1', NULL, 'Admin', '0', 'admin/AdminManage.vue', 'el-icon-a-031');
INSERT INTO `menu` VALUES (2, '002', '用户信息管理', '1', NULL, 'User', '0', 'user/UserManage.vue', 'el-icon-a-01');
INSERT INTO `menu` VALUES (3, '003', '品牌信息管理', '1', NULL, 'Storage', '1', 'storage/StorageManage', 'el-icon-a-041');
INSERT INTO `menu` VALUES (4, '004', '内存型号管理', '1', NULL, 'Goodstype', '1', 'goodstype/GoodstypeManage', 'el-icon-bank-card');
INSERT INTO `menu` VALUES (5, '005', '物品信息管理 ', '1', NULL, 'Goods', '1,2', 'goods/GoodsManage', 'el-icon-mobile-phone');
INSERT INTO `menu` VALUES (6, '006', '操作日志', '1', NULL, 'Record', '0,1,2', 'record/RecordManage', 'el-icon-a-061');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                           `goods` int(11) NOT NULL COMMENT '货品id',
                           `userId` int(11) NULL DEFAULT NULL COMMENT '取货人/补货人',
                           `admin_id` int(11) NULL DEFAULT NULL COMMENT '操作人id',
                           `count` int(11) NULL DEFAULT NULL COMMENT '数量',
                           `createtime` datetime NULL DEFAULT NULL COMMENT '操作时间',
                           `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 1, 3, 2, 100, '2024-09-02 20:46:48', '取货');
INSERT INTO `record` VALUES (12, 1, 3, 1, -5, '2024-09-04 15:32:27', '');
INSERT INTO `record` VALUES (15, 4, 3, 1, 100, '2024-09-06 21:08:13', '');
INSERT INTO `record` VALUES (16, 4, 3, 1, -50, '2024-09-09 21:08:25', '');
INSERT INTO `record` VALUES (17, 4, 3, 1, 100, '2024-09-09 21:17:24', '');
INSERT INTO `record` VALUES (18, 4, 3, 1, -200, '2024-09-10 21:17:33', '');
INSERT INTO `record` VALUES (19, 4, 3, 1, 100, '2024-09-11 11:15:11', '');
INSERT INTO `record` VALUES (20, 1, 3, 1, -10, '2024-09-11 15:02:57', '');
INSERT INTO `record` VALUES (27, 1, 6, 2, 10, '2024-09-11 17:45:31', '入库测试3');

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
                            `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                            `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌',
                            `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (1, '华为', '销量较好');
INSERT INTO `storage` VALUES (2, '苹果', '销量较好');
INSERT INTO `storage` VALUES (3, '小米', '销量较好');
INSERT INTO `storage` VALUES (4, 'OPPO', '销量较差');
INSERT INTO `storage` VALUES (5, 'VIVO', '销量较差');
INSERT INTO `storage` VALUES (6, '三星', '销量较差');
INSERT INTO `storage` VALUES (7, '菠萝', '销量滞销');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                         `no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
                         `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名字',
                         `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
                         `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
                         `sex` int(11) NULL DEFAULT NULL COMMENT '性别',
                         `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
                         `role_id` int(11) NULL DEFAULT NULL COMMENT '角色 0超级管理员，1管理员，2普通账号',
                         `isValid` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Y' COMMENT '是否有效，Y有效，其他无效',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'superadmin', '张三', 'f4067b29461078b48dca3939fe51921f', 18, 1, '18855079621', 0, 'Y');
INSERT INTO `user` VALUES (2, 'admin', '李四', 'f4067b29461078b48dca3939fe51921f', 19, 0, '18855079621', 1, 'Y');
INSERT INTO `user` VALUES (3, 'user', '王五', '8480ab2fe7901cca20de78c0d7f9a7fa', 23, 0, '13333333333', 2, 'Y');
INSERT INTO `user` VALUES (6, 'user2', '赵六', 'f4067b29461078b48dca3939fe51921f', 23, 0, '19475562654', 2, 'Y');
INSERT INTO `user` VALUES (7, 'user3', '赵六', 'f4067b29461078b48dca3939fe51921f', 23, 0, '18373981943', 2, 'Y');

SET FOREIGN_KEY_CHECKS = 1;
