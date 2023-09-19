CREATE TABLE `users` (
  `email_hash` char(64) NOT NULL,
  `display_name` varchar(256),
  `access_requested_on` date,
  `access_approved_on` date,
  `key_hash` char(64),
  `secret_hash` char(64),
  `hashing_algo` varchar(128),
  `hashing_version` varchar(24),
  `last_hashed_date` date,
  `reset_key` char(64),
  `reset_key_date` date,
  PRIMARY KEY (`email_hash`),
  KEY `token` (`key_hash`, `secret_hash`),
  KEY `hashing` (`hashing_algo`, `hashing_version`),
  KEY `last_hashed` (`last_hashed_date`),
  KEY `access_requested_on` (`access_requested_on`),
  KEY `reset_key` (`reset_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system';

