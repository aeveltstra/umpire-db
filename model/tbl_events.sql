DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `seq` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Actions taken by users, registered for audits';
ALTER TABLE `events`
  ADD PRIMARY KEY (`seq`);
ALTER TABLE `events`
  MODIFY `seq` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
