
DROP TABLE IF EXISTS `language_codes`;
CREATE TABLE `language_codes` (
 `code` varchar(24) NOT NULL,
 PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Codes for languages. Follow ISO 639-2 as defined by BCP 47.'