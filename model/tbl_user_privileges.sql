DROP TABLE IF EXISTS `user_privileges`;

CREATE TABLE `user_privileges` (
  `seq` int(10) UNSIGNED NOT NULL,
  `name` varchar(48) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='What actions users are allowed to perform';

ALTER TABLE `user_privileges`
  ADD PRIMARY KEY (`seq`),
  ADD UNIQUE KEY `user_privilege_name` (`name`);

ALTER TABLE `user_privileges`
  MODIFY `seq` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
