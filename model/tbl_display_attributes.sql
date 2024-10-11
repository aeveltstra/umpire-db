DROP TABLE IF EXISTS `display_attributes`;

CREATE TABLE `display_attributes` (
  `display` char(24) NOT NULL,
  `attribute` char(24) CHARACTER SET utf8 NOT NULL,
  `display_sequence` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which display, in which order?';

ALTER TABLE `display_attributes`
  ADD UNIQUE KEY `pk_display_attribs_attrib` (`display`,`attribute`),
  ADD KEY `ix_display_attribs_display_id` (`display`),
  ADD KEY `ix_display_attribs_seq` (`display_sequence`),
  ADD KEY `fk_display_attrib_attribs_id` (`attribute`) USING BTREE;

ALTER TABLE `display_attributes`
  ADD CONSTRAINT `fk_display_attribs_attrib_id` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_display_attribs_display_id` FOREIGN KEY (`display`) REFERENCES `displays` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

