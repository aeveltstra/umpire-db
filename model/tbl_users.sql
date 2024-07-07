DROP TABLE IF EXISTS `users`;

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
  `reset_key_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system';

ALTER TABLE `users`
  ADD PRIMARY KEY (`seq`),
  ADD UNIQUE KEY `user_uq_email_hash` (`email_hash`),
  ADD KEY `user_token` (`key_hash`,`secret_hash`),
  ADD KEY `user_ix_hashing` (`hashing_algo`,`hashing_version`),
  ADD KEY `user_ix_keys_last_hashed` (`last_hashed_date`),
  ADD KEY `user_ix_access_requested_on` (`access_requested_on`),
  ADD KEY `user_ix_reset_key` (`reset_key`),
  ADD KEY `user_ix_reset_key_date` (`reset_key_date`);

ALTER TABLE `users`
  MODIFY `seq` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
