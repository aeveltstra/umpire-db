
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
 `seq` int(10) NOT NULL AUTO_INCREMENT,
 `case_id` bigint(20) NOT NULL,
 `email` varchar(256) NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`seq`),
 KEY `ix_subscriptions_case` (`case_id`) USING BTREE,
 KEY `ix_subscriptions_email` (`email`) USING BTREE,
 KEY `ix_subscriptions_modified` (`at`) USING BTREE,
 CONSTRAINT `fk_subscriptions_case` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Notify people of case changes.'
