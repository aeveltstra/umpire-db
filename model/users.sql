CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'just a sequence nr.',
  `key_hash` char(24) NOT NULL,
  `secret_hash` char(24) NOT NULL,
  `display_name` varchar(256),
  `email` varchar(512),
  `encryption_algo` varchar(128),
  `encryption_version` varchar(24),
  `last_encrypted` date NOT NULL,
  `requested_access_on` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`key_hash`, `secret_hash`),
  KEY `encryption_algo` (`encryption_algo`),
  KEY `last_encrypted` (`last_encrypted`),
  KEY `email` (`email`),
  KEY `requested_access_on` (`requested_access_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system';

