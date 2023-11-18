--
-- Constraints for dumped tables
--

--
-- Constraints for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  ADD CONSTRAINT `fk_attrib_id` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lang_code` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `date_values`
--
ALTER TABLE `date_values`
  ADD CONSTRAINT `fk_1` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_7` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enums`
--
ALTER TABLE `enums`
  ADD CONSTRAINT `fk_enums_attrib_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_enums_lang_languages` FOREIGN KEY (`language_code`) REFERENCES `language_codes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enum_values`
--
ALTER TABLE `enum_values`
  ADD CONSTRAINT `fk_attrib_id_enum_values` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_case_id_enum_values` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_enum_id_enum_values` FOREIGN KEY (`enum_id`) REFERENCES `enums` (`enum_value`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `form_attributes`
--
ALTER TABLE `form_attributes`
  ADD CONSTRAINT `fk_form_attrib_attribs_id` FOREIGN KEY (`attribute`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_form_form_forms_id` FOREIGN KEY (`form`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `integer_values`
--
ALTER TABLE `integer_values`
  ADD CONSTRAINT `fk_5` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_6` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `longtext_values`
--
ALTER TABLE `longtext_values`
  ADD CONSTRAINT `fk_4` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_8` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shorttext_values`
--
ALTER TABLE `shorttext_values`
  ADD CONSTRAINT `fk_10` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_3` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `time_values`
--
ALTER TABLE `time_values`
  ADD CONSTRAINT `fk_2` FOREIGN KEY (`case_id`) REFERENCES `profiles` (`case_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_9` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_events`
--
ALTER TABLE `user_events`
  ADD CONSTRAINT `fk_user_events_event` FOREIGN KEY (`event`) REFERENCES `events` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_events_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role_privileges`
--
ALTER TABLE `user_role_privileges`
  ADD CONSTRAINT `fk_user_role_privileges_privilege` FOREIGN KEY (`privilege`) REFERENCES `user_privileges` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_role_privileges_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role_users`
--
ALTER TABLE `user_role_users`
  ADD CONSTRAINT `fk_user_role_users_role` FOREIGN KEY (`role`) REFERENCES `user_roles` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_role_users_user` FOREIGN KEY (`user`) REFERENCES `users` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE;
