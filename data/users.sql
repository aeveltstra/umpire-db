TRUNCATE TABLE `users`;
INSERT INTO `users` (`seq`, `email_hash`, `display_name`, `access_requested_on`, `access_approved_on`, `key_hash`, `secret_hash`, `hashing_algo`, `hashing_version`, `last_hashed_date`, `reset_key`, `reset_key_date`) VALUES
(1, 'b67f71a782accc6e99740fb4d0295572d81c9a15f8e9e24174e0d1a2a1cee7435d1a99833490983eaba65c68022122bcea002e29fb8d76716e97db79741819dc', 'Anonymous', '2023-05-01', '2023-05-01', NULL, NULL, 'sha512', NULL, '2023-05-01', NULL, NULL);

