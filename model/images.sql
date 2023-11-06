CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'just a sequence nr.',
  `case_id` varchar(24) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `url` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Public and private media';
