-- MariaDB dump 10.19-11.1.2-MariaDB, for osx10.16 (arm64)
--
-- Host: 192.168.192.3    Database: acore_auth
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `salt` binary(32) NOT NULL,
  `verifier` binary(32) NOT NULL,
  `session_key` binary(40) DEFAULT NULL,
  `totp_secret` varbinary(128) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reg_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `last_attempt_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` int unsigned NOT NULL DEFAULT '0',
  `locked` tinyint unsigned NOT NULL DEFAULT '0',
  `lock_country` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '00',
  `last_login` timestamp NULL DEFAULT NULL,
  `online` int unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint unsigned NOT NULL DEFAULT '2',
  `mutetime` bigint NOT NULL DEFAULT '0',
  `mutereason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `muteby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `locale` tinyint unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `recruiter` int unsigned NOT NULL DEFAULT '0',
  `totaltime` int unsigned NOT NULL DEFAULT '0',
  `restore_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Account System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES
(1,'LINYU',0xF84C38ED92FA69E6B4BE6F180240E3B98CB122776B55600E20113594683D9D0D,0x4BB0DE5FED57D31F36A588C4F2452FA2C22B2CE047818486EAE70FBF862FB94E,0xC2F58029C2968900C01442B80C244728D1FC00FFDA512B13375E857F059D494FB34DEA2EDE857A64,NULL,'','','2023-10-07 11:28:42','192.168.1.1','192.168.1.1',0,0,'00','2023-10-12 07:47:26',0,2,0,'','',4,'Win',0,28499,'1'),
(2,'PPCLEAN',0x0999F5D035C640D685CA9A6ACFCF89E524FC6CAF6F0DEAA08CC4E312B6EF93C7,0xD686FBCEB2144FCEB13D16E22E1BDACE9E1FF8A3ADA3BB1589FEACCC8701BC37,0x6143C4C1B12CA35676ECE12317C76A5FB2483C822ADB66385A4322CD62436C6D38C810809CD038B0,NULL,'PPCLEAN@QQ.COM','','2023-10-08 03:32:35','192.168.1.1','192.168.1.1',0,0,'00','2023-10-09 14:11:40',0,2,0,'','',4,'Win',0,2484,'2ec69a51aba45a9cee9f14515daaf5b980457'),
(3,'MORTAL',0x3F445D2E4CE3309C36CBC33D997FB3DCC1B76B35950E11E804854C8200720E3F,0x193CF34932D79733FA66519227FF6BB0684195F7851697066C4360BB10D9F80E,0x9D28BB14C185298600B924D27D0521BC952F2CE6BA74D82857003F45DD3B3533061AECD9B2295465,NULL,'WQRBOY@163.COM','','2023-10-08 03:44:19','117.147.29.73','117.147.29.73',0,0,'00','2023-10-11 12:47:27',0,2,0,'','',4,'Win',0,7236,'1');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

--
-- Table structure for table `account_access`
--

DROP TABLE IF EXISTS `account_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_access` (
  `id` int unsigned NOT NULL,
  `gmlevel` tinyint unsigned NOT NULL,
  `RealmID` int NOT NULL DEFAULT '-1',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_access`
--

/*!40000 ALTER TABLE `account_access` DISABLE KEYS */;
INSERT INTO `account_access` VALUES
(1,3,-1,'');
/*!40000 ALTER TABLE `account_access` ENABLE KEYS */;

--
-- Table structure for table `account_banned`
--

DROP TABLE IF EXISTS `account_banned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_banned` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` int unsigned NOT NULL DEFAULT '0',
  `unbandate` int unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banreason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ban List';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_banned`
--

/*!40000 ALTER TABLE `account_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_banned` ENABLE KEYS */;

--
-- Table structure for table `account_muted`
--

DROP TABLE IF EXISTS `account_muted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_muted` (
  `guid` int unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `mutedate` int unsigned NOT NULL DEFAULT '0',
  `mutetime` int unsigned NOT NULL DEFAULT '0',
  `mutedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mutereason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`guid`,`mutedate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mute List';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_muted`
--

/*!40000 ALTER TABLE `account_muted` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_muted` ENABLE KEYS */;

--
-- Table structure for table `autobroadcast`
--

DROP TABLE IF EXISTS `autobroadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autobroadcast` (
  `realmid` int NOT NULL DEFAULT '-1',
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `weight` tinyint unsigned DEFAULT '1',
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobroadcast`
--

/*!40000 ALTER TABLE `autobroadcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `autobroadcast` ENABLE KEYS */;

--
-- Table structure for table `build_info`
--

DROP TABLE IF EXISTS `build_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_info` (
  `build` int NOT NULL,
  `majorVersion` int DEFAULT NULL,
  `minorVersion` int DEFAULT NULL,
  `bugfixVersion` int DEFAULT NULL,
  `hotfixVersion` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `winAuthSeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `win64AuthSeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac64AuthSeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `winChecksumSeed` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `macChecksumSeed` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`build`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_info`
--

/*!40000 ALTER TABLE `build_info` DISABLE KEYS */;
INSERT INTO `build_info` VALUES
(5875,1,12,1,NULL,NULL,NULL,NULL,'95EDB27C7823B363CBDDAB56A392E7CB73FCCA20','8D173CC381961EEBABF336F5E6675B101BB513E5'),
(6005,1,12,2,NULL,NULL,NULL,NULL,NULL,NULL),
(6141,1,12,3,NULL,NULL,NULL,NULL,NULL,NULL),
(8606,2,4,3,NULL,NULL,NULL,NULL,'319AFAA3F2559682F9FF658BE01456255F456FB1','D8B0ECFE534BC1131E19BAD1D4C0E813EEE4994F'),
(9947,3,1,3,NULL,NULL,NULL,NULL,NULL,NULL),
(10505,3,2,2,'a',NULL,NULL,NULL,NULL,NULL),
(11159,3,3,0,'a',NULL,NULL,NULL,NULL,NULL),
(11403,3,3,2,NULL,NULL,NULL,NULL,NULL,NULL),
(11723,3,3,3,'a',NULL,NULL,NULL,NULL,NULL),
(12340,3,3,5,'a',NULL,NULL,NULL,'CDCBBD5188315E6B4D19449D492DBCFAF156A347','B706D13FF2F4018839729461E3F8A0E2B5FDC034'),
(13930,3,3,5,'a',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `build_info` ENABLE KEYS */;

--
-- Table structure for table `ip_banned`
--

DROP TABLE IF EXISTS `ip_banned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_banned` (
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `bandate` int unsigned NOT NULL,
  `unbandate` int unsigned NOT NULL,
  `bannedby` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Banned IPs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_banned`
--

/*!40000 ALTER TABLE `ip_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_banned` ENABLE KEYS */;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `time` int unsigned NOT NULL,
  `realm` int unsigned NOT NULL,
  `type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` tinyint unsigned NOT NULL DEFAULT '0',
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

--
-- Table structure for table `logs_ip_actions`
--

DROP TABLE IF EXISTS `logs_ip_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_ip_actions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Identifier',
  `account_id` int unsigned NOT NULL COMMENT 'Account ID',
  `character_guid` int unsigned NOT NULL COMMENT 'Character Guid',
  `type` tinyint unsigned NOT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `systemnote` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Notes inserted by system',
  `unixtime` int unsigned NOT NULL COMMENT 'Unixtime',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Allows users to add a comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Used to log ips of individual actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_ip_actions`
--

/*!40000 ALTER TABLE `logs_ip_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_ip_actions` ENABLE KEYS */;

--
-- Table structure for table `motd`
--

DROP TABLE IF EXISTS `motd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motd` (
  `realmid` int NOT NULL,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motd`
--

/*!40000 ALTER TABLE `motd` DISABLE KEYS */;
INSERT INTO `motd` VALUES
(-1,'Welcome to an AzerothCore server.');
/*!40000 ALTER TABLE `motd` ENABLE KEYS */;

--
-- Table structure for table `realmcharacters`
--

DROP TABLE IF EXISTS `realmcharacters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `realmcharacters` (
  `realmid` int unsigned NOT NULL DEFAULT '0',
  `acctid` int unsigned NOT NULL,
  `numchars` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Realm Character Tracker';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realmcharacters`
--

/*!40000 ALTER TABLE `realmcharacters` DISABLE KEYS */;
INSERT INTO `realmcharacters` VALUES
(1,1,1),
(1,2,1),
(1,3,1);
/*!40000 ALTER TABLE `realmcharacters` ENABLE KEYS */;

--
-- Table structure for table `realmlist`
--

DROP TABLE IF EXISTS `realmlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `realmlist` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `localAddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '127.0.0.1',
  `localSubnetMask` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '255.255.255.0',
  `port` smallint unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint unsigned NOT NULL DEFAULT '0',
  `flag` tinyint unsigned NOT NULL DEFAULT '2',
  `timezone` tinyint unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `population` float NOT NULL DEFAULT '0',
  `gamebuild` int unsigned NOT NULL DEFAULT '12340',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  CONSTRAINT `realmlist_chk_1` CHECK ((`population` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Realm System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realmlist`
--

/*!40000 ALTER TABLE `realmlist` DISABLE KEYS */;
INSERT INTO `realmlist` VALUES
(1,'ICWOW','wow.ly011.top','127.0.0.1','255.255.255.0',8085,0,0,1,0,0,12340);
/*!40000 ALTER TABLE `realmlist` ENABLE KEYS */;

--
-- Table structure for table `secret_digest`
--

DROP TABLE IF EXISTS `secret_digest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secret_digest` (
  `id` int unsigned NOT NULL,
  `digest` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secret_digest`
--

/*!40000 ALTER TABLE `secret_digest` DISABLE KEYS */;
/*!40000 ALTER TABLE `secret_digest` ENABLE KEYS */;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates` (
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'filename with extension of the update.',
  `hash` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sha1 hash of the sql file.',
  `state` enum('RELEASED','CUSTOM','MODULE','ARCHIVED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp when the query was applied.',
  `speed` int unsigned NOT NULL DEFAULT '0' COMMENT 'time the query takes to apply in ms.',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all applied updates in this database.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
INSERT INTO `updates` VALUES
('2016_07_09_00.sql','B692C4D5E96D26616E1E655D99DD27F6AC4FFDA6','ARCHIVED','2021-10-14 07:13:44',1),
('2016_07_09_01.sql','DE551E4708FE31AAC60CEF69466BBC5DFAC46F79','ARCHIVED','2021-10-14 07:13:44',1),
('2016_07_10_00.sql','0AE2F7FB1E9C1E2BC2870D0EB817F3C87E0A39B3','ARCHIVED','2021-10-14 07:13:44',1),
('2016_08_25_00.sql','707016C338350676C814D7926DFB6081E57091C3','ARCHIVED','2021-10-14 07:13:44',1),
('2016_08_25_01.sql','A5A2BE04C8E8E85CD177B8684DFFEACF71C9CF69','ARCHIVED','2021-10-14 07:13:44',1),
('2016_09_04_00.sql','420ACF7160BF5549BC298EB6A1319969789DA140','ARCHIVED','2021-10-14 07:13:44',1),
('2016_11_18_00.sql','92D22B3A45466470239402367D94C3791A243EF7','ARCHIVED','2021-10-14 07:13:44',1),
('2016_11_19_00.sql','C55E73648F661F40237B03F266F7169D231B3D8D','ARCHIVED','2021-10-14 07:13:44',1),
('2017_08_19_00.sql','E4457FFFFC0D3F86750F07CF88F549529E1B27E5','ARCHIVED','2021-10-14 07:13:44',1),
('2017_08_20_01.sql','E6190311E1A12E259C6CD21ACFC8BAA1D3F597DF','ARCHIVED','2021-10-14 07:13:44',1),
('2017_12_05_00.sql','475860B881DE6E9CAC93AD3B37E7AAA8D63FB1B9','ARCHIVED','2021-10-14 07:13:44',1),
('2018_01_21_00.sql','570FC5FC653D81B0E498E3EAB6706C9868CE8079','ARCHIVED','2021-10-14 07:13:44',1),
('2018_09_17_00.sql','31743E771FFA4C92D6B6CF747DE4302814BDF257','ARCHIVED','2021-10-14 07:13:44',1),
('2019_01_05_00.sql','2449121ABB0D5004BF6941B340F5C294AD95EBE9','ARCHIVED','2021-10-14 07:13:44',1),
('2019_02_08_00.sql','18FF48FC1B1C238D44198FA1E2D422BAB4C9C338','ARCHIVED','2021-10-14 07:13:44',1),
('2019_02_17_00.sql','1F4C4A15313A261088E40909DCCAA068EAAAAAAE','ARCHIVED','2021-10-14 07:13:44',1),
('2019_04_13_00.sql','183C28E079DAB46AD6F7C0617E19346CAD043141','ARCHIVED','2021-10-14 07:13:44',1),
('2020_02_07_00.sql','9549BF7354B4FA5A661EC094A2C3AAF665678152','ARCHIVED','2021-10-14 07:13:44',1),
('2021_01_25_00.sql','5FA7F802E04CBF66848938FE7FC14FC4CC815F3C','ARCHIVED','2021-10-15 00:59:32',51),
('2021_03_21_00.sql','1E98E516DAD70DC101E339950C1BCC1D15BE78B6','ARCHIVED','2021-10-15 00:59:32',102),
('2021_03_23_00.sql','0EA578B7108559B4E54CAE99714F695659EDE6E5','ARCHIVED','2021-10-15 00:59:32',77),
('2021_05_13_00.sql','B9CABD6897489B20D6523AEDC61AD9075BCA398A','ARCHIVED','2021-10-15 00:59:32',104),
('2021_05_26_00.sql','435822D9482BA2C5F0D8E54E3A587611A453B0FA','ARCHIVED','2021-10-15 00:59:32',71),
('2021_05_30_00.sql','E70A61123CBE2DC8AF332D03DF1889EB0DF3CEAB','ARCHIVED','2021-10-15 00:59:32',64),
('2021_06_17_00.sql','36686970C025046FD49FA4BF6F8283A1AE2BE8F3','ARCHIVED','2021-10-15 00:59:33',52),
('2021_10_14_00.sql','D4378AFC454DF8351A6DE6C6B6144F82C62980A5','ARCHIVED','2021-10-15 00:59:33',53),
('2021_10_14_01_auth.sql','A4495131ADD2AB4AB6682C1621683963247368F0','ARCHIVED','2022-01-22 02:36:20',20),
('2021_11_06_00.sql','E08D11C492289879C460BB063457DAD968545752','ARCHIVED','2022-01-22 02:36:20',39),
('2022_01_23_00.sql','6291006CD2B38EEE02EDDD8AEB6A952477854C77','ARCHIVED','2022-04-24 18:19:14',28),
('2022_04_24_00.sql','CFB8D5B896B2A5900F5E5A2262B356E0842405BB','ARCHIVED','2022-08-21 12:56:35',34),
('2022_04_28_00.sql','26108CBD35D4B885A90CEC25665DCBC00FD06809','ARCHIVED','2022-08-21 12:56:35',30),
('2022_08_21_00.sql','E333B1A3FD1A25298D29B8FCAA0EE8AE5985202F','ARCHIVED','2023-01-31 23:19:58',28),
('2023_01_31_00.sql','0ACDD35EC9745231BCFA701B78056DEF94D0CC53','ARCHIVED','2023-04-23 21:18:58',36),
('2023_02_20_00.sql','B2A8F337A3699322D19729AF07ADC5607FAEEF83','ARCHIVED','2023-04-23 21:18:58',56),
('2023_04_23_00.sql','F853503AAFB22DB3493F2ADC8B6BBB7B648EDBA9','ARCHIVED','2023-04-23 21:18:59',522),
('2023_04_24_00.sql','D164A70B22B2462464484614018C3218B3259AE4','RELEASED','2023-10-07 09:47:42',9);
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;

--
-- Table structure for table `updates_include`
--

DROP TABLE IF EXISTS `updates_include`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_include` (
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'directory to include. $ means relative to the source directory.',
  `state` enum('RELEASED','ARCHIVED','CUSTOM') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if the directory contains released or archived updates.',
  PRIMARY KEY (`path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of directories where we want to include sql updates.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates_include`
--

/*!40000 ALTER TABLE `updates_include` DISABLE KEYS */;
INSERT INTO `updates_include` VALUES
('$/data/sql/archive/db_auth','ARCHIVED'),
('$/data/sql/custom/db_auth','CUSTOM'),
('$/data/sql/updates/db_auth','RELEASED');
/*!40000 ALTER TABLE `updates_include` ENABLE KEYS */;

--
-- Table structure for table `uptime`
--

DROP TABLE IF EXISTS `uptime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uptime` (
  `realmid` int unsigned NOT NULL,
  `starttime` int unsigned NOT NULL DEFAULT '0',
  `uptime` int unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AzerothCore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Uptime system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uptime`
--

/*!40000 ALTER TABLE `uptime` DISABLE KEYS */;
INSERT INTO `uptime` VALUES
(1,1550400304,121,0,'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
(1,1550400454,1440,0,'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
(1,1661068597,0,0,'AzerothCore rev. 5d6dfca80cf1 2022-08-21 09:48:09 +0200 (new-squash-POGGIES branch) (Win64, RelWithDebInfo, Static)'),
(1,1675207201,0,0,'AzerothCore rev. e7cbc80a913b 2023-01-31 22:22:22 +0000 (master branch) (Win64, RelWithDebInfo, Static)'),
(1,1682284745,0,0,'AzerothCore rev. 5dc6f9cf78f1 2023-04-23 21:03:18 +0000 (master branch) (Win64, RelWithDebInfo, Static)'),
(1,1696672082,190,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696672355,6009,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696678418,8830,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696688218,2108,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696690487,6730,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696726022,17290,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696743361,1691,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696745320,669,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696746007,788,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696746798,1028,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696747906,908,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696748840,849,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696749985,4929,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696754951,3848,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696758859,3548,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696762547,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696762559,3069,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696765682,130,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696765838,189,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696766031,129,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696766217,6428,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696772660,1269,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696773985,1269,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696775292,789,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696776139,369,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696776554,248,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696776805,188,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696777012,789,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696777804,5830,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696812422,36250,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696848725,21309,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696898822,27490,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696926354,8829,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696935215,909,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696937687,1269,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696939003,909,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696939963,10449,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696950467,5948,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1696985222,37150,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697022413,69,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697022493,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697022525,129,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697022714,308,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697023192,68,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697023271,4988,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697028317,14469,2,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697070521,11649,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082195,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082214,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082233,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082251,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082270,0,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697082288,11529,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697093848,2888,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697096785,6668,1,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)'),
(1,1697103488,310,0,'AzerothCore rev. a2c6af4c5683+ 2023-10-01 07:26:31 +0000 (master branch) (Unix, RelWithDebInfo, Static)');
/*!40000 ALTER TABLE `uptime` ENABLE KEYS */;

--
-- Dumping routines for database 'acore_auth'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-12 17:43:58
