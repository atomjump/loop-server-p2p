

DROP TABLE IF EXISTS `tbl_client_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_client_read_request` (
  `int_request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_p2p_layer_id` int(10) unsigned NOT NULL,
  `var_request` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `date_when_received` datetime DEFAULT NULL,
  `enm_type` enum('read','write','static') CHARACTER SET latin1 DEFAULT NULL,
  `enm_status` enum('responded','waiting','timeout') CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_read_id`)
  KEY `check_new` (`int_layer_id`, `int_read_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_peer` (
      `int_peer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `var_peer_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
	  `date_activated` datetime DEFAULT NULL,
  KEY `last_updated` (`last_updated`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `tbl_invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_invitation` (
	  `int_peer_id` int(10) unsigned NOT NULL,
	  `int_p2p_layer_id` int(10) unsigned NOT NULL,
	  `var_sql_insert` varchar(150000) COLLATE utf8_bin DEFAULT NULL,
	  `enm_status` enum('waiting','accepted','completed','rejected','timeout') CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`int_peer_id`, `int_layer_id`)
  KEY 'invite_status' (`int_layer_id`, `enm_status`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_session_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_session_update` (
	  `int_session_update_id` int(10) unsigned NOT NULL,
	  `int_p2p_layer_id` int(10) unsigned NOT NULL,
	  `var_update` varchar(150000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`int_peer_id`, `int_layer_id`)
  KEY 'invite_status' (`int_layer_id`, `enm_status`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `tbl_users_p2p_layer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_users_p2p_layer` (
      `int_p2p_layer_id` int(10) unsigned NOT NULL,
      `int_user_id` int(10) unsigned NOT NULL,
      PRIMARY KEY (`int_peer_id`, `int_layer_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `tbl_traffic_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_traffic_balance` (
      `int_peer_id` int(10) unsigned NOT NULL,
      `int_p2p_layer_id` int(10) unsigned NOT NULL,
      `int_requests_handled` int(15) unsigned NOT NULL,
      PRIMARY KEY (`int_peer_id`, `int_layer_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `tbl_p2p_layer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_layer` (
  `int_p2p_layer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `var_layer_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `int_requests_handled` int(15) unsigned NOT NULL,
  PRIMARY KEY (`int_layer_id`),
  KEY `tbl_advert_passcode` (`passcode`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;


