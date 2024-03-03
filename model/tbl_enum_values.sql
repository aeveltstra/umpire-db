DROP TABLE IF EXISTS `enum_values`;

CREATE TABLE `enum_values` (
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` varchar(24) DEFAULT NULL,
  `user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerated values for enumerated attributes: a single choice from multiple. Useful for standardized nouns like hair color and units of measurement.';

ALTER TABLE `enum_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  ADD KEY `ix_enum_values_modified` (`at`),
  ADD KEY `ix_enum_values_user` (`user`),
  ADD KEY `ix_enum_values_case_id` (`case_id`) USING BTREE,
  ADD KEY `ix_enum_values_value` (`value`) USING BTREE;

ALTER TABLE `enum_values`
  ADD CONSTRAINT `fk_attrib_id_enum_values` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_case_id_enum_values` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_enum_id_enum_values` FOREIGN KEY (`value`) REFERENCES `enums` (`enum_value`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_enum_values_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
