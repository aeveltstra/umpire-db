DROP TABLE IF EXISTS `projections`;

CREATE TABLE `projections` (
 `id` char(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
ALTER TABLE `projections`
  ADD PRIMARY KEY (`id`);
