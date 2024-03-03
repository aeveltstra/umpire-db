DROP TABLE IF EXISTS `shorttext_values`;

CREATE TABLE `shorttext_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` tinytext,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Short values for text attributes: less than 256 characters. Useful for names and places.';

ALTER TABLE `shorttext_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `ix_shorttext_user` (`user`) USING BTREE,
  ADD KEY `ix_shorttext_modified` (`at`) USING BTREE,
  ADD KEY `ix_shorttext_case_id` (`case_id`) USING BTREE,
  ADD KEY `ix_shorttext_attribute` (`attribute_id`) USING BTREE;
ALTER TABLE `shorttext_values` ADD FULLTEXT KEY `ix_shorttext_fulltext` (`value`);

ALTER TABLE `shorttext_values`
  ADD CONSTRAINT `fk_shorttext_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`),
  ADD CONSTRAINT `fk_shorttext_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`),
  ADD CONSTRAINT `fk_shorttext_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
