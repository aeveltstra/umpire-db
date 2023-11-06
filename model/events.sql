CREATE TABLE `events` (
  `seq` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Actions taken by users, registered for audits';
