DROP TABLE IF EXISTS `forms`;

CREATE TABLE `forms` (
 `id` char(24) NOT NULL,
  `url_after_entry` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);
