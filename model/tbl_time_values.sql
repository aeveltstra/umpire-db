DROP TABLE IF EXISTS `time_values`;

CREATE TABLE `time_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` time DEFAULT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for time and date attributes';

ALTER TABLE `time_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `ix_time_value` (`value`),
  ADD KEY `ix_times_modified` (`at`) USING BTREE,
  ADD KEY `ix_times_attribute` (`attribute_id`),
  ADD KEY `ix_times_case` (`case_id`) USING BTREE,
  ADD KEY `ix_times_user` (`user`) USING BTREE;

ALTER TABLE `time_values`
  ADD CONSTRAINT `fk_times_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_times_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_times_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
