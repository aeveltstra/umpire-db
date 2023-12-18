TRUNCATE TABLE `user_roles`;
INSERT INTO `user_roles` (`seq`, `name`) VALUES
(1, 'dbo'),
(2, 'user_administrator'),
(3, 'case_manager'),
(4, 'all_case_editor'),
(5, 'all_case_viewer'),
(6, 'own_case_editor'),
(7, 'own_case_viewer'),
(8, 'case_adder');
