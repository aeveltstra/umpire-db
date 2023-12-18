
DROP TABLE IF EXISTS `time_values`;
CREATE TABLE `time_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` time NOT NULL,
 `user` int(10) unsigned NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `fk_case_id` (`case_id`),
 KEY `value` (`value`),
 KEY `ix_date_values_user` (`user`),
 KEY `ix_date_values_modified` (`at`),
 CONSTRAINT `fk_2` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_9` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for time and date attributes'