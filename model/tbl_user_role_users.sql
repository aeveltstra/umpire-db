DROP TABLE IF EXISTS `user_role_users`;

CREATE TABLE `user_role_users` (
  `role` int(10) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns users to user roles';

ALTER TABLE `user_role_users`
  ADD PRIMARY KEY (`role`,`user`),
  ADD KEY `fk_user_role_users_user` (`user`);

ALTER TABLE `user_role_users`
  ADD CONSTRAINT `fk_user_role_users_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_role_users_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;
