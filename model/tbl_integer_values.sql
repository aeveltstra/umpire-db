DROP TABLE IF EXISTS `integer_values`;

CREATE TABLE `integer_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` bigint(20) DEFAULT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes';

ALTER TABLE `integer_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  ADD KEY `ix_integer_values_modified` (`at`) USING BTREE,
  ADD KEY `ix_integer_values_user` (`user`) USING BTREE,
  ADD KEY `ix_integers_case` (`case_id`) USING BTREE,
  ADD KEY `ix_integer_values_attribute` (`attribute_id`);

ALTER TABLE `integer_values`
  ADD CONSTRAINT `fk_integer_values_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_integer_values_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_integer_values_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
