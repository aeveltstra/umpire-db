--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_type` (`data_type`),
  ADD KEY `ix_attribute_is_write_once` (`is_write_once`);

--
-- Indexes for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  ADD PRIMARY KEY (`language_code`,`attribute_id`),
  ADD KEY `fk_attrib_id` (`attribute_id`);

--
-- Indexes for table `date_values`
--
ALTER TABLE `date_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `value` (`value`),
  ADD KEY `fk_1` (`case_id`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`);

--
-- Indexes for table `enums`
--
ALTER TABLE `enums`
  ADD PRIMARY KEY (`attribute_id`,`enum_value`,`language_code`) USING BTREE,
  ADD KEY `ix_lang` (`language_code`),
  ADD KEY `ix_attrib` (`attribute_id`) USING BTREE,
  ADD KEY `ix_enum_value` (`enum_value`) USING BTREE;

--
-- Indexes for table `enum_values`
--
ALTER TABLE `enum_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `enum_values_case_ids` (`case_id`),
  ADD KEY `enum_values_enum_ids` (`enum_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`seq`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form_attributes`
--
ALTER TABLE `form_attributes`
  ADD UNIQUE KEY `pk_form_form_attribute` (`form`,`attribute`),
  ADD KEY `ix_form_form` (`form`),
  ADD KEY `ix_form_display_seq` (`display_sequence`),
  ADD KEY `ix_hide_on_entry` (`hide_on_entry`),
  ADD KEY `ix_form_attrib` (`form`),
  ADD KEY `fk_form_attrib_attribs_id` (`attribute`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `ix_img_is_public` (`is_public`);

--
-- Indexes for table `integer_values`
--
ALTER TABLE `integer_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `fk_5` (`case_id`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`);

--
-- Indexes for table `language_codes`
--
ALTER TABLE `language_codes`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `longtext_values`
--
ALTER TABLE `longtext_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `fk_4` (`case_id`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`);
ALTER TABLE `longtext_values` ADD FULLTEXT KEY `value` (`value`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `shorttext_values`
--
ALTER TABLE `shorttext_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `fk_case_id` (`case_id`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`);
ALTER TABLE `shorttext_values` ADD FULLTEXT KEY `value` (`value`);

--
-- Indexes for table `time_values`
--
ALTER TABLE `time_values`
  ADD PRIMARY KEY (`attribute_id`,`case_id`),
  ADD KEY `fk_case_id` (`case_id`),
  ADD KEY `value` (`value`),
  ADD KEY `ix_date_values_user` (`user`),
  ADD KEY `ix_date_values_modified` (`at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`seq`),
  ADD UNIQUE KEY `email_hash_ix` (`email_hash`),
  ADD KEY `token` (`key_hash`,`secret_hash`),
  ADD KEY `hashing` (`hashing_algo`,`hashing_version`),
  ADD KEY `last_hashed` (`last_hashed_date`),
  ADD KEY `access_requested_on` (`access_requested_on`),
  ADD KEY `reset_key` (`reset_key`);

--
-- Indexes for table `user_events`
--
ALTER TABLE `user_events`
  ADD PRIMARY KEY (`seq`),
  ADD KEY `ix_user_events_at_datetime` (`at`),
  ADD KEY `fk_user_events_event` (`event`),
  ADD KEY `fk_user_events_user` (`user`);

--
-- Indexes for table `user_privileges`
--
ALTER TABLE `user_privileges`
  ADD PRIMARY KEY (`seq`),
  ADD UNIQUE KEY `user_privilege_name` (`name`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD UNIQUE KEY `seq` (`seq`),
  ADD UNIQUE KEY `user_role_name` (`name`);

--
-- Indexes for table `user_role_privileges`
--
ALTER TABLE `user_role_privileges`
  ADD PRIMARY KEY (`role`,`privilege`),
  ADD KEY `fk_user_role_privileges_privilege` (`privilege`);

--
-- Indexes for table `user_role_users`
--
ALTER TABLE `user_role_users`
  ADD PRIMARY KEY (`role`,`user`),
  ADD KEY `fk_user_role_users_user` (`user`);
