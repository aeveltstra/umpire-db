
DROP TABLE IF EXISTS `form_attributes`;
CREATE TABLE `form_attributes` (
 `form` char(24) NOT NULL,
 `attribute` char(24) CHARACTER SET utf8 NOT NULL,
 `display_sequence` smallint(5) unsigned NOT NULL,
 `hide_on_entry` tinyint(1) NOT NULL DEFAULT '0',
 UNIQUE KEY `pk_form_form_attribute` (`form`,`attribute`),
 KEY `ix_form_form` (`form`),
 KEY `ix_form_display_seq` (`display_sequence`),
 KEY `ix_hide_on_entry` (`hide_on_entry`),
 KEY `fk_form_attrib_attribs_id` (`attribute`) USING BTREE,
 CONSTRAINT `fk_form_attrib_attribs_id` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_form_form_forms_id` FOREIGN KEY (`form`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which form, in which order?'