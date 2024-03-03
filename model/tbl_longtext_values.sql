DROP TABLE IF EXISTS `longtext_values`;

CREATE TABLE `longtext_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` text,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Huge values for text attributes. Think reports, DNA kits, family trees.';

ALTER TABLE `longtext_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  ADD KEY `ix_longtext_values_case` (`case_id`) USING BTREE,
  ADD KEY `ix_longtext_values_user` (`user`) USING BTREE,
  ADD KEY `ix_longtext_values_modified` (`at`) USING BTREE,
  ADD KEY `ix_longtext_attribute` (`attribute_id`);
ALTER TABLE `longtext_values` ADD FULLTEXT KEY `ix_longtext_values_fulltext` (`value`);

ALTER TABLE `longtext_values`
  ADD CONSTRAINT `fk_longtext_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_longtext_entry` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_longtext_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
