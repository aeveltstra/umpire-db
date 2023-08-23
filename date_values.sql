CREATE TABLE `date_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` int(4) NOT NULL,
 `value` date NOT NULL,
 PRIMARY KEY (`attribute_id`,`case_id`),
 KEY `fk_case_id` (`case_id`),
 KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes'
