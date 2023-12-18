
DROP TABLE IF EXISTS `user_privileges`;
CREATE TABLE `user_privileges` (
 `seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `name` varchar(48) NOT NULL,
 PRIMARY KEY (`seq`),
 UNIQUE KEY `user_privilege_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='What actions users are allowed to perform'