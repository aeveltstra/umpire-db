DROP TABLE IF EXISTS `entries_roles`;

CREATE TABLE `entries_roles` (
  `entry` bigint(10) NOT NULL,
  `role` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns user roles to entries, so users can access them.';

ALTER TABLE `entries_roles`
  ADD PRIMARY KEY (`entry`,`role`),
  ADD KEY `ix_entries_roles_entry` (`entry`),
  ADD KEY `ix_entries_roles_role` (`role`);

ALTER TABLE `entries_roles`
  ADD CONSTRAINT `fk_entries_roles_entry` FOREIGN KEY (`entry`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_entries_roles_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;
