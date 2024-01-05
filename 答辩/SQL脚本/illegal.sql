/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : rainbowzh

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 05/01/2024 21:16:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for illegal
-- ----------------------------
DROP TABLE IF EXISTS `illegal`;
CREATE TABLE `illegal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nword` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `flag` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of illegal
-- ----------------------------
INSERT INTO `illegal` VALUES (1, '2', 0);
INSERT INTO `illegal` VALUES (5, 'test', 1);

SET FOREIGN_KEY_CHECKS = 1;
