DROP TABLE IF EXISTS `user_role_privileges`;

CREATE TABLE `user_role_privileges` (
  `role` int(10) UNSIGNED NOT NULL,
  `privilege` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns actions to user roles';

ALTER TABLE `user_role_privileges`
  ADD PRIMARY KEY (`role`,`privilege`),
  ADD KEY `fk_user_role_privileges_privilege` (`privilege`);

ALTER TABLE `user_role_privileges`
  ADD CONSTRAINT `fk_user_role_privileges_privilege` FOREIGN KEY (`privilege`) REFERENCES `user_privileges` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_role_privileges_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;
