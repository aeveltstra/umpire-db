DROP TABLE IF EXISTS `subscriptions`;

CREATE TABLE `subscriptions` (
  `seq` int(10) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `email` varchar(256) NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Notify people of case changes.';

ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`seq`),
  ADD KEY `ix_subscriptions_case` (`case_id`) USING BTREE,
  ADD KEY `ix_subscriptions_email` (`email`(255)) USING BTREE,
  ADD KEY `ix_subscriptions_modified` (`at`) USING BTREE;

ALTER TABLE `subscriptions`
  MODIFY `seq` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `subscriptions`
  ADD CONSTRAINT `fk_subscriptions_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE;

