
DROP TABLE IF EXISTS `attribute_translations`;
CREATE TABLE `attribute_translations` (
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `attribute_id` char(24) NOT NULL,
  `translation` text NOT NULL,
  `hint` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`language_code`,`attribute_id`),
  KEY `fk_attrib_id` (`attribute_id`),
  CONSTRAINT `fk_attrib_id` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lang_code` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations of attribute captions'	
