
DROP TABLE IF EXISTS `integer_values`;
CREATE TABLE `integer_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` bigint(20) NOT NULL,
 `user` int(10) unsigned NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
 KEY `ix_integer_values_modified` (`at`) USING BTREE,
 KEY `ix_integer_values_user` (`user`) USING BTREE,
 KEY `ix_integers_case` (`case_id`) USING BTREE,
 CONSTRAINT `fk_integer_values_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_integer_values_case` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_integer_values_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes'