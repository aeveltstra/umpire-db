
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
 `case_id` bigint(20) NOT NULL AUTO_INCREMENT,
 `added_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `form` char(24) CHARACTER SET ascii NOT NULL,
 PRIMARY KEY (`case_id`),
 KEY `ix_profiles_form` (`form`) USING BTREE,
 CONSTRAINT `fk_profiles_form` FOREIGN KEY (`form`) REFERENCES `forms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Cases of missing and unidentified people'