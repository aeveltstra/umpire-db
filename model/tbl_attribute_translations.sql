
DROP TABLE IF EXISTS `attribute_translations`;

CREATE TABLE `attribute_translations` (
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `attribute_id` char(24) NOT NULL,
  `translation` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hint` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations of attribute captions';

ALTER TABLE `attribute_translations`
  ADD PRIMARY KEY (`language_code`,`attribute_id`),
  ADD KEY `fk_attrib_id` (`attribute_id`);

ALTER TABLE `attribute_translations`
  ADD CONSTRAINT `fk_attrib_id` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lang_code` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

