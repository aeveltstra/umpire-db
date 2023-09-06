CREATE TABLE `images` (
 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'just a sequence nr.',
 `case_id` varchar(24) NOT NULL,
 `is_public` tinyint(1) NOT NULL,
 `url` varchar(512) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `case_id` (`case_id`),
 KEY `ix_img_is_public` (`is_public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Public and private media';

