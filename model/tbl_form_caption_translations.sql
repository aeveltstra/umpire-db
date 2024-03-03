DROP TABLE IF EXISTS `form_caption_translations`;

CREATE TABLE `form_caption_translations` (
  `form` char(24) CHARACTER SET ascii NOT NULL,
  `language` varchar(24) CHARACTER SET ascii NOT NULL,
  `caption` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations for display captions for forms';

ALTER TABLE `form_caption_translations`
  ADD PRIMARY KEY (`form`,`language`),
  ADD KEY `fk_form_captions_language` (`language`);

ALTER TABLE `form_caption_translations`
  ADD CONSTRAINT `fk_form_captions_form` FOREIGN KEY (`form`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_form_captions_language` FOREIGN KEY (`language`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
