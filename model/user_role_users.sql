CREATE TABLE `user_role_users` (
  `role` int(10) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns users to user roles';
