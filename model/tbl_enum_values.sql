CREATE TABLE `enum_values` (
 `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `attribute_id` char(24) NOT NULL,
 `case_id` bigint(20) NOT NULL,
 `value` varchar(24) NULL,
 `user` int(10) unsigned NOT NULL,
 PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
 KEY `ix_enum_values_modified` (`at`),
 KEY `ix_enum_values_user` (`user`),
 KEY `ix_enum_values_case_id` (`case_id`) USING BTREE,
 KEY `ix_enum_values_enum_id` (`enum_id`) USING BTREE,
 CONSTRAINT `fk_attrib_id_enum_values` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_case_id_enum_values` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_enum_id_enum_values` FOREIGN KEY (`enum_id`) REFERENCES `enums` (`enum_value`) ON DELETE CASCADE ON UPDATE CASCADE
 CONSTRAINT `fk_enum_values_user` FOREIGN KEY (user) REFERENCES users (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerated values for enumerated attributes: a single choice from multiple. Useful for standardized nouns like hair color and units of measurement.'