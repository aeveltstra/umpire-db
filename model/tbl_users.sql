
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
 `seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `email_hash` char(128) NOT NULL,
 `display_name` varchar(256) DEFAULT NULL,
 `access_requested_on` date DEFAULT NULL,
 `access_approved_on` date DEFAULT NULL,
 `key_hash` char(128) DEFAULT NULL,
 `secret_hash` char(128) DEFAULT NULL,
 `hashing_algo` varchar(128) DEFAULT NULL,
 `hashing_version` varchar(24) DEFAULT NULL,
 `last_hashed_date` date DEFAULT NULL,
 `reset_key` char(128) DEFAULT NULL,
 `reset_key_date` date DEFAULT NULL,
 PRIMARY KEY (`seq`),
 UNIQUE KEY `email_hash_ix` (`email_hash`),
 KEY `token` (`key_hash`,`secret_hash`),
 KEY `hashing` (`hashing_algo`,`hashing_version`),
 KEY `last_hashed` (`last_hashed_date`),
 KEY `access_requested_on` (`access_requested_on`),
 KEY `reset_key` (`reset_key`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system'