DROP TABLE IF EXISTS `location_values`;

CREATE TABLE `location_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `x` smallint(5) UNSIGNED DEFAULT NULL,
  `x_decimals` mediumint(8) UNSIGNED DEFAULT NULL,
  `x_sign` tinyint(3) UNSIGNED DEFAULT NULL,
  `y` smallint(5) UNSIGNED DEFAULT NULL,
  `y_decimals` mediumint(8) UNSIGNED DEFAULT NULL,
  `y_sign` tinyint(3) UNSIGNED DEFAULT NULL,
  `z` smallint(5) UNSIGNED DEFAULT NULL,
  `z_decimals` mediumint(8) UNSIGNED DEFAULT NULL,
  `z_sign` tinyint(3) UNSIGNED DEFAULT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for location attributes';

ALTER TABLE `location_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  ADD KEY `ix_location_value` (`x`,`x_decimals`,`x_sign`,`y`,`y_decimals`,`y_sign`,`z`,`z_decimals`,`z_sign`),
  ADD KEY `ix_location_values_user` (`user`),
  ADD KEY `ix_location_values_modified` (`at`),
  ADD KEY `ix_location_values_case` (`case_id`) USING BTREE;

ALTER TABLE `location_values`
  ADD CONSTRAINT `fk_locations_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_locations_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_locations_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;

