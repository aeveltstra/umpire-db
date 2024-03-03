DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `entry_id` bigint(20) NOT NULL,
  `added_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `form` char(24) CHARACTER SET ascii NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Form entries. Stores identifiers that tie attribute values to forms.';

ALTER TABLE `entries`
  ADD PRIMARY KEY (`entry_id`),
  ADD KEY `ix_entries_form` (`form`) USING BTREE;

ALTER TABLE `entries`
  MODIFY `entry_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `entries`
  ADD CONSTRAINT `fk_entries_form` FOREIGN KEY (`form`) REFERENCES `forms` (`id`);
