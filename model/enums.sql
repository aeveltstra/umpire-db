CREATE TABLE `enums` (
  `attribute_id` char(24) NOT NULL,
  `enum_value` varchar(24) NOT NULL,
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `caption` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All possible enumerations for all attributes';
