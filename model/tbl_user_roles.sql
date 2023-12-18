
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
 `seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `name` varchar(48) NOT NULL,
 UNIQUE KEY `seq` (`seq`),
 UNIQUE KEY `user_role_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Determines what users can do'