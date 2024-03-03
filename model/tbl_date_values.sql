DROP TABLE IF EXISTS `date_values`;

CREATE TABLE `date_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `epoch` timestamp NULL DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `day` int(11) DEFAULT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for date attributes, assuming a proleptic Gregorian calendar';

ALTER TABLE `date_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`,`at`) USING BTREE,
  ADD KEY `ix_date_value` (`year`,`month`,`day`),
  ADD KEY `ix_date_epoch` (`epoch`),
  ADD KEY `ix_date_year_month` (`year`,`month`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`),
  ADD KEY `ix_date_values_case` (`case_id`) USING BTREE;

ALTER TABLE `date_values`
  ADD CONSTRAINT `fk_dates_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dates_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dates_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE;
