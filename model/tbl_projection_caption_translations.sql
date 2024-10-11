DROP TABLE IF EXISTS `projection_caption_translations`;

CREATE TABLE `projection_caption_translations` (
  `projection` char(24) CHARACTER SET ascii NOT NULL,
  `language` varchar(24) CHARACTER SET ascii NOT NULL,
  `caption` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations for projection captions';

ALTER TABLE `projection_caption_translations`
  ADD PRIMARY KEY (`projection`,`language`),
  ADD KEY `fk_projection_captions_language` (`language`);

ALTER TABLE `projection_caption_translations`
  ADD CONSTRAINT `fk_projection_captions_projection` FOREIGN KEY (`projection`) REFERENCES `projections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_projection_captions_language` FOREIGN KEY (`language`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
