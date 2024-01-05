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

 Date: 05/01/2024 21:16:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `postId` int NULL DEFAULT NULL,
  `userId` int NULL DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `flag` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `postId`(`postId` ASC) USING BTREE,
  INDEX `userId`(`userId` ASC) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '你*什么时候*啊', 1, 21, '2023-12-01 17:21:31', 1);
INSERT INTO `comment` VALUES (2, 'test1', 1, 0, '2023-12-02 01:11:47', 0);
INSERT INTO `comment` VALUES (3, 'test2', 1, 2, '2023-12-02 01:11:59', 1);
INSERT INTO `comment` VALUES (4, 'test3', 1, 17, '2023-12-02 01:12:08', 1);
INSERT INTO `comment` VALUES (5, 'test4', 1, 18, '2023-12-02 01:12:17', 1);
INSERT INTO `comment` VALUES (6, 'test5', 1, 19, '2023-12-02 01:12:30', 1);
INSERT INTO `comment` VALUES (7, '玩原神玩的', 2, 0, '2023-01-01 00:00:00', 1);
INSERT INTO `comment` VALUES (8, '幽默', 1, 0, '2023-12-02 14:19:55', 1);
INSERT INTO `comment` VALUES (9, '你的脸怎么绿了?', 5, 0, '2023-12-02 14:25:11', 1);
INSERT INTO `comment` VALUES (10, '你的脸怎么绿了?', 5, 2, '2023-12-02 14:27:18', 1);
INSERT INTO `comment` VALUES (11, 'test？？？', 4, 2, '2023-12-13 14:29:24', 1);
INSERT INTO `comment` VALUES (12, 'test', 4, 2, '2023-12-02 14:31:15', 1);
INSERT INTO `comment` VALUES (14, '测', 7, 0, '2023-12-02 15:32:56', 1);
INSERT INTO `comment` VALUES (15, '测测你的', 7, 0, '2023-12-02 15:33:03', 1);
INSERT INTO `comment` VALUES (16, '测测你的', 7, 0, '2023-12-02 15:33:32', 1);
INSERT INTO `comment` VALUES (17, '我再测测\n', 7, 0, '2023-12-02 15:35:08', 1);
INSERT INTO `comment` VALUES (18, '我超，op', 2, 2, '2023-12-03 21:49:26', 1);
INSERT INTO `comment` VALUES (19, '好想吃捏', 9, 0, '2023-12-18 19:49:08', 1);
INSERT INTO `comment` VALUES (20, '我也想吃', 9, 19, '2023-12-28 08:15:26', 1);
INSERT INTO `comment` VALUES (21, '我也想吃', 9, 18, '2023-12-28 08:28:36', 1);
INSERT INTO `comment` VALUES (22, '我也想吃捏', 9, 20, '2023-12-28 08:32:00', 1);
INSERT INTO `comment` VALUES (23, 'nnn\n', 9, 23, '2023-12-28 11:14:29', 1);
INSERT INTO `comment` VALUES (24, 'youmo', 1, 0, '2024-01-03 20:24:21', 1);
INSERT INTO `comment` VALUES (25, '111', 1, 0, '2024-01-04 11:34:59', 1);
INSERT INTO `comment` VALUES (26, 'aaa', 23, 2, '2024-01-05 16:45:24', 1);
INSERT INTO `comment` VALUES (27, '测试评论1', 9, 24, '2024-01-05 20:30:25', 1);

SET FOREIGN_KEY_CHECKS = 1;
