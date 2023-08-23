CREATE TABLE `attributes` (
  `id` char(24) NOT NULL,
  `data_type` enum('integer','shorttext','longtext','date','time','enum') CHARACTER SET ascii NOT NULL,
  `display_sequence` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `data_type` (`data_type`),
  KEY `display_sequence` (`display_sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerate text attributes'	
