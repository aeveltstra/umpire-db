
DROP TABLE IF EXISTS `enum_values`;
CREATE TABLE `enum_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `enum_id` varchar(24) NOT NULL,
  PRIMARY KEY (`attribute_id`,`case_id`),
  KEY `enum_values_case_ids` (`case_id`),
  KEY `enum_values_enum_ids` (`enum_id`),
  CONSTRAINT `fk_attrib_id_enum_values` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_case_id_enum_values` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enum_id_enum_values` FOREIGN KEY (`enum_id`) REFERENCES `enums` (`enum_value`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerated values for enumerated attributes: a single choice from multiple. Useful for standardized nouns like hair color and units of measurement.'	
