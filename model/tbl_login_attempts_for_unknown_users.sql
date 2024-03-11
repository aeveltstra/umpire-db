DROP TABLE IF EXISTS `login_attempts_for_unknown_users`;

CREATE TABLE `login_attempts_for_unknown_users` (
  `seq` int(10) UNSIGNED NOT NULL,
  `email_hash` char(128) DEFAULT NULL,
  `key_hash` char(128) DEFAULT NULL,
  `secret_hash` char(128) DEFAULT NULL,
  `browser_fingerprint` varchar(512) DEFAULT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Attempts to log in for users unknown to the system';

ALTER TABLE `login_attempts_for_unknown_users`
  ADD PRIMARY KEY (`seq`),
  ADD KEY `lafuu_email_hash_ix` (`email_hash`),
  ADD KEY `lafuu_key_hash` (`key_hash`),
  ADD KEY `lafuu_secret_hash` (`secret_hash`),
  ADD KEY `lafuu_browser_fingerprint` (`browser_fingerprint`),
  ADD KEY `lafuu_attempted_at` (`at`);

ALTER TABLE `login_attempts_for_unknown_users`
  MODIFY `seq` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
