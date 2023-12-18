
DROP TABLE IF EXISTS `enums`;
CREATE TABLE `enums` (
 `attribute_id` char(24) NOT NULL,
 `enum_value` varchar(24) NOT NULL,
 `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
 `caption` varchar(256) NOT NULL,
 PRIMARY KEY (`attribute_id`,`enum_value`,`language_code`) USING BTREE,
 KEY `ix_lang` (`language_code`),
 KEY `ix_attrib` (`attribute_id`) USING BTREE,
 KEY `ix_enum_value` (`enum_value`) USING BTREE,
 CONSTRAINT `fk_enums_attrib_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_enums_lang_languages` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All possible enumerations for all attributes'