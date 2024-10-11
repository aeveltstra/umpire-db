DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'just a sequence nr.',
  `case_id` bigint(20) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `url` varchar(512) NOT NULL,
  `attribute` char(24) NOT NULL,
  `alt` varchar(256) NULL,
  `description` varchar(1024) NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Public and private media';

ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_img_is_public` (`is_public`),
  ADD KEY `ix_image_attribute` (`attribute`),
  ADD KEY `ix_image_user` (`user`),
  ADD KEY `ix_image_modified` (`at`),
  ADD KEY `ix_image_case` (`case_id`) USING BTREE;

ALTER TABLE `images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'just a sequence nr.';

ALTER TABLE `images`
  ADD CONSTRAINT `fk_image_attribute` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_image_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_img_case` FOREIGN KEY (`case_id`) REFERENCES `entries` (`entry_id`) ON DELETE CASCADE ON UPDATE CASCADE;
