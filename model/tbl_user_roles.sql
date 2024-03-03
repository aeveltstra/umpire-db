DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE `user_roles` (
  `seq` int(10) UNSIGNED NOT NULL,
  `name` varchar(48) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Determines what users can do';

ALTER TABLE `user_roles`
  ADD UNIQUE KEY `seq` (`seq`),
  ADD UNIQUE KEY `user_role_name` (`name`);

ALTER TABLE `user_roles`
  MODIFY `seq` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
