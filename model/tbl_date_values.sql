
DROP TABLE IF EXISTS `date_values`;
CREATE TABLE `date_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` date NOT NULL,
  `user` int(10) unsigned NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  KEY `value` (`value`),
  KEY `ix_date_values_user` (`user`),
  KEY `ix_date_values_modified` (`at`),
  KEY `ix_date_values_case` (`case_id`) USING BTREE,
  CONSTRAINT `fk_dates_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dates_case` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for date attributes'	
