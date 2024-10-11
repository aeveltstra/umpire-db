DROP TABLE IF EXISTS `projection_attributes`;

CREATE TABLE `projection_attributes` (
  `projection` char(24) NOT NULL,
  `attribute` char(24) CHARACTER SET utf8 NOT NULL,
  `display_sequence` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which projection, in which order?';

ALTER TABLE `projection_attributes`
  ADD UNIQUE KEY `pk_projection_attrib` (`projection`,`attribute`),
  ADD KEY `ix_projection_attribs_projection` (`projection`),
  ADD KEY `ix_projection_attribs_display_seq` (`display_sequence`),
  ADD KEY `fk_projection_attrib_id` (`attribute`) USING BTREE;

ALTER TABLE `projection_attributes`
  ADD CONSTRAINT `fk_projection_attrib_id` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_projection_attribs_projection_id` FOREIGN KEY (`projection`) REFERENCES `projections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

