CREATE TABLE `attribute_translations` (
  `language_code` varchar(24) CHARACTER SET ascii NOT NULL,
  `attribute_id` char(24) NOT NULL,
  `translation` text NOT NULL,
  `hint` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations of attribute captions';
