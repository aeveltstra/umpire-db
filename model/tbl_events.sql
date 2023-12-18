
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
 `seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `name` varchar(256) NOT NULL,
 PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Actions taken by users, registered for audits'