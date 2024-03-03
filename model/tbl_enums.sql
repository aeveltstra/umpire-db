DROP TABLE IF EXISTS `enums`;

CREATE TABLE `enums` (
  `attribute_id` char(24) NOT NULL,
  `enum_value` varchar(24) NOT NULL DEFAULT '',
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `caption` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All possible enumerations for all attributes';

ALTER TABLE `enums`
  ADD PRIMARY KEY (`attribute_id`,`enum_value`,`language_code`) USING BTREE,
  ADD KEY `ix_lang` (`language_code`),
  ADD KEY `ix_attrib` (`attribute_id`) USING BTREE,
  ADD KEY `ix_enum_value` (`enum_value`) USING BTREE;

ALTER TABLE `enums`
  ADD CONSTRAINT `fk_enums_attrib_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_enums_lang_languages` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
