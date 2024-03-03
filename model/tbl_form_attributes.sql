DROP TABLE IF EXISTS `form_attributes`;

CREATE TABLE `form_attributes` (
  `form` char(24) NOT NULL,
  `attribute` char(24) CHARACTER SET utf8 NOT NULL,
  `display_sequence` smallint(5) UNSIGNED NOT NULL,
  `hide_on_entry` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which form, in which order?';

ALTER TABLE `form_attributes`
  ADD UNIQUE KEY `pk_form_form_attribute` (`form`,`attribute`),
  ADD KEY `ix_form_form` (`form`),
  ADD KEY `ix_form_display_seq` (`display_sequence`),
  ADD KEY `ix_hide_on_entry` (`hide_on_entry`),
  ADD KEY `fk_form_attrib_attribs_id` (`attribute`) USING BTREE;

ALTER TABLE `form_attributes`
  ADD CONSTRAINT `fk_form_attrib_attribs_id` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_form_form_forms_id` FOREIGN KEY (`form`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
