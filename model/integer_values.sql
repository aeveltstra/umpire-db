CREATE TABLE `integer_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `value` bigint(20) NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes';
