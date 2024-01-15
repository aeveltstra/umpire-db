
DROP TABLE IF EXISTS `longtext_values`;
CREATE TABLE `longtext_values` (
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` text NULL,
 `user` int(10) unsigned NOT NULL,
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
 KEY `ix_longtext_values_case` (`case_id`) USING BTREE,
 KEY `ix_longtext_values_user` (`user`) USING BTREE,
 KEY `ix_longtext_values_modified` (`at`) USING BTREE,
 FULLTEXT KEY `ix_longtext_values_fulltext` (`value`),
 CONSTRAINT `fk_longtext_case` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_longtext_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Huge values for text attributes. Think reports, DNA kits, family trees.'