DROP TABLE IF EXISTS `location_values`;
CREATE TABLE `location_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `x` smallint unsigned NULL,
  `x_decimals` MEDIUMINT unsigned NULL,
  `x_sign` tinyint unsigned NULL,
  `y` smallint unsigned NULL,
  `y_decimals` MEDIUMINT unsigned NULL,
  `y_sign` tinyint unsigned NULL,
  `z` smallint unsigned NULL,
  `z_decimals` MEDIUMINT unsigned NULL,
  `z_sign` tinyint unsigned NULL,
  `user` int(10) unsigned NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  KEY `ix_location_value` (`x`, `x_decimals`, `x_sign`, `y`, `y_decimals`, `y_sign`, `z`, `z_decimals`, `z_sign`),
  KEY `ix_location_values_user` (`user`),
  KEY `ix_location_values_modified` (`at`),
  KEY `ix_location_values_case` (`case_id`) USING BTREE,
  CONSTRAINT `fk_locations_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_locations_case` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for location attributes'	
