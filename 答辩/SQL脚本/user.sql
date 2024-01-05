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

 Date: 05/01/2024 21:16:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `birthday` date NULL DEFAULT NULL,
  `banTime` int NULL DEFAULT NULL,
  `lastVisit` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '\\img\\users\\aca\\avatar\\aca.png', 'aca', 'DeUatJfPtWZY3K3wVQjq+Q==', '2002-03-05', -1, '2024-01-05 20:59:26');
INSERT INTO `user` VALUES (2, '\\img\\users\\陈叔叔\\avatar\\8920e6741fc2808cce5b81bc27abdbda291655d3.png@240w_240h_1c_1s_!web-avatar-space-header.avif', 'cr', 'JclJrCVCDBD18V1wXqWSbw==', '1978-01-23', 0, '2024-01-04 11:35:16');
INSERT INTO `user` VALUES (17, '\\img\\users\\lala\\avatar\\382241455@2x.png', 'lala', 'psrmXC1RCXzIyq0tEcloAQ==', '2023-09-21', 0, '2023-12-27 04:05:12');
INSERT INTO `user` VALUES (18, '\\img\\users\\q\\avatar\\345376694@2x.png', 'q', 'YYkMgmSJ4enQ0SgqZkK3ww==', '2023-08-29', -1, '2024-01-03 20:38:46');
INSERT INTO `user` VALUES (19, '\\img\\users\\qq\\avatar\\327085484@2x.png', 'qq', 'CKy/fIW901on5Kijj270Uw==', '2023-09-02', -3, '2024-01-03 20:39:21');
INSERT INTO `user` VALUES (20, '\\img\\users\\黑手哥\\avatar\\黑手哥.png', 'hsg', 'vy9VgyAaxp5YBUS3qk3Prw==', '2023-07-05', 0, '2023-12-27 04:32:27');
INSERT INTO `user` VALUES (21, '\\img\\users\\蒙古上单\\avatar\\蒙古上单.png', 'mgsd', 'HGh5SQaYQl+bVe4Wt1gutw==', '2023-01-10', 0, '2023-12-26 21:02:14');
INSERT INTO `user` VALUES (22, '\\img\\users\\我测\\avatar\\356879290@2x.png', '我测', 'vfZt1J+aepsQ5PXHaD5BMg==', '2023-12-16', 0, NULL);
INSERT INTO `user` VALUES (23, '\\img\\users\\fha\\avatar\\356879314@2x.png', 'fha', 'p/J4zNezc7rO30BCb7XJzw==', '2023-01-02', 0, '2023-12-28 11:14:50');
INSERT INTO `user` VALUES (24, '\\img\\users\\测试1\\avatar\\356879290@2x.png', '测试1', 'UIAJI0r13tIPjMaXIr9TSw==', '2024-01-01', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
