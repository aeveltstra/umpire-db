REATE TABLE `attribute_translations` (
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `attribute_id` char(24) NOT NULL,
  `translation` text NOT NULL,
  PRIMARY KEY (`language_code`,`attribute_id`),
  KEY `fk_attribute_id` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations of attribute captions'	
