
DROP TABLE IF EXISTS `user_events`;
CREATE TABLE `user_events` (
 `seq` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
 `user` int(10) unsigned NOT NULL,
 `event` int(10) unsigned NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`seq`),
 KEY `ix_user_events_at_datetime` (`at`),
 KEY `fk_user_events_event` (`event`),
 KEY `fk_user_events_user` (`user`),
 CONSTRAINT `fk_user_events_event` FOREIGN KEY (`event`) REFERENCES `events` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_user_events_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=binary COMMENT='When which user took which action'