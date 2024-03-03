DROP TABLE IF EXISTS `user_events`;

CREATE TABLE `user_events` (
  `seq` bigint(20) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED DEFAULT NULL,
  `event` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='When which user took which action';

ALTER TABLE `user_events`
  ADD PRIMARY KEY (`seq`),
  ADD KEY `ix_user_events_at_datetime` (`at`),
  ADD KEY `fk_user_events_event` (`event`),
  ADD KEY `fk_user_events_user` (`user`);

ALTER TABLE `user_events`
  MODIFY `seq` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `user_events`
  ADD CONSTRAINT `fk_user_events_event` FOREIGN KEY (`event`) REFERENCES `events` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_events_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE SET NULL ON UPDATE CASCADE;
