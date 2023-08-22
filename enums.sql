CREATE TABLE `enums` (
 `attribute_id` char(24) NOT NULL,
 `enum_value` char(24) NOT NULL,
 PRIMARY KEY (`attribute_id`,`enum_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All possible enumerations for all attributes';
