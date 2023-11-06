CREATE TABLE `user_role_privileges` (
  `role` int(10) UNSIGNED NOT NULL,
  `privilege` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns actions to user roles';
