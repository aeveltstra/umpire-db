DROP TABLE IF EXISTS `displays`;

CREATE TABLE `displays` (
 `id` char(24) NOT NULL,
  `url_after_entry` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
ALTER TABLE `displays`
  ADD PRIMARY KEY (`id`);
