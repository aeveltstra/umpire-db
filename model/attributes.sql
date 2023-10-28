CREATE TABLE `attributes` (
 `id` char(24) NOT NULL,
 `data_type` enum('integer','shorttext','longtext','date','time','enum','percent') CHARACTER SET ascii NOT NULL,
 `min` int(11) NOT NULL DEFAULT '0',
 `max` int(11) NOT NULL DEFAULT '256',
 `default` varchar(256) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `data_type` (`data_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerate text attributes'