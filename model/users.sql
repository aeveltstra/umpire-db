CREATE TABLE `users` (
  `seq` int(10) UNSIGNED NOT NULL,
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
  `reset_key_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system';
