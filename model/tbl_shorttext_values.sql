
DROP TABLE IF EXISTS `shorttext_values`;
CREATE TABLE `shorttext_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` tinytext NULL,
 `user` int(10) unsigned NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `ix_date_values_user` (`user`),
 KEY `ix_date_values_modified` (`at`),
 KEY `ix_date_values_case_id` (`case_id`) USING BTREE,
 FULLTEXT KEY `ix_dates_value_fulltext` (`value`),
 CONSTRAINT `fk_dates_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Short values for text attributes: less than 256 characters. Useful for names and places.'