
DROP TABLE IF EXISTS `user_role_privileges`;
CREATE TABLE `user_role_privileges` (
 `role` int(10) unsigned NOT NULL,
 `privilege` int(10) unsigned NOT NULL,
 PRIMARY KEY (`role`,`privilege`),
 KEY `fk_user_role_privileges_privilege` (`privilege`),
 CONSTRAINT `fk_user_role_privileges_privilege` FOREIGN KEY (`privilege`) REFERENCES `user_privileges` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_user_role_privileges_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns actions to user roles'