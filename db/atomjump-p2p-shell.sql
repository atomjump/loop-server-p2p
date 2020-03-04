DROP TABLE IF EXISTS `php_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `php_session` (
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `user_id` varchar(16) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `last_updated` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `session_data` longtext,
  PRIMARY KEY (`session_id`),
  KEY `last_updated` (`last_updated`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_client_read_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_client_read_request` (
  `int_read_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_layer_id` int(10) unsigned NOT NULL,
  `var_request` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `date_when_received` datetime DEFAULT NULL,
  `enm_status` enum('responded','waiting','timeout') CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_read_id`)
  KEY `check_new` (`int_layer_id`, `int_read_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `tbl_client_write_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_client_write_request` (
  `int_write_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_layer_id` int(10) unsigned NOT NULL,
  `var_request` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `date_when_received` datetime DEFAULT NULL,
  `enm_status` enum('responded','waiting','timeout') CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_write_id`)
  KEY `check_new` (`int_layer_id`, `int_write_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_client_static_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_client_static_request` (

  `int_static_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_layer_id` int(10) unsigned NOT NULL,
  `var_request` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `date_when_received` datetime DEFAULT NULL,
  `enm_status` enum('responded','waiting','timeout') CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_static_id`)
  KEY `check_new` (`int_layer_id`, `int_static_id`)

) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_invitation` (
	  `var_sql_insert` varchar(150000) COLLATE utf8_bin DEFAULT NULL,

  KEY `last_updated` (`last_updated`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `tbl_traffic_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_traffic_balance` (

) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_layer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_layer` (
  `int_layer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `passcode` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_layer_id`),
  KEY `tbl_advert_passcode` (`passcode`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


