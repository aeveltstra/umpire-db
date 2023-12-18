
DROP TABLE IF EXISTS `user_role_users`;
CREATE TABLE `user_role_users` (
 `role` int(10) unsigned NOT NULL,
 `user` int(10) unsigned NOT NULL,
 PRIMARY KEY (`role`,`user`),
 KEY `fk_user_role_users_user` (`user`),
 CONSTRAINT `fk_user_role_users_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_user_role_users_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns users to user roles'