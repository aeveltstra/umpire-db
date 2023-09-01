CREATE TABLE `longtext_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` text NOT NULL,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `fk_4` (`case_id`),
 FULLTEXT KEY `value` (`value`),
 CONSTRAINT `fk_4` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_8` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes'
