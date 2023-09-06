CREATE TABLE `integer_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` bigint(20) NOT NULL,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `fk_5` (`case_id`),
 CONSTRAINT `fk_5` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_6` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes'
