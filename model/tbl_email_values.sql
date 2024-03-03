DROP TABLE IF EXISTS `email_values`;

CREATE TABLE `email_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` tinytext,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email address attributes.';

ALTER TABLE `email_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `ix_email_values_user` (`user`),
  ADD KEY `ix_email_values_modified` (`at`),
  ADD KEY `ix_email_values_case_id` (`case_id`) USING BTREE,
  ADD KEY `ix_email_values_attribute` (`attribute_id`);

ALTER TABLE `email_values`
  ADD CONSTRAINT `fk_email_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_email_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_email_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
