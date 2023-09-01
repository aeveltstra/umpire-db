CREATE TABLE `time_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` time NOT NULL,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `fk_case_id` (`case_id`),
 KEY `value` (`value`),
 CONSTRAINT `fk_2` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_9` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for time attributes'
