DROP TABLE IF EXISTS `display_caption_translations`;

CREATE TABLE `display_caption_translations` (
  `display` char(24) CHARACTER SET ascii NOT NULL,
  `language` varchar(24) CHARACTER SET ascii NOT NULL,
  `caption` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations for display captions';

ALTER TABLE `display_caption_translations`
  ADD PRIMARY KEY (`display`,`language`),
  ADD KEY `fk_display_captions_language` (`language`);

ALTER TABLE `display_caption_translations`
  ADD CONSTRAINT `fk_display_captions_display` FOREIGN KEY (`display`) REFERENCES `displays` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_display_captions_language` FOREIGN KEY (`language`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
