CREATE TABLE `form_attributes` (
  `form` char(24) NOT NULL,
  `attribute` char(24) CHARACTER SET utf8 NOT NULL,
  `display_sequence` smallint(5) UNSIGNED NOT NULL,
  `hide_on_entry` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which form, in which order?';
