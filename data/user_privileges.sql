TRUNCATE TABLE `user_privileges`;
INSERT INTO `user_privileges` (`seq`, `name`) VALUES
(1, 'may_see_access_applications'),
(2, 'may_accept_access_applications'),
(3, 'may_reject_access_applications'),
(4, 'may_enter_case'),
(5, 'may_track_own_case_changes');
(6, 'may_change_own_case'),
(7, 'may_export_own_case'),
(8, 'may_see_own_case'),
(9, 'may_self_assign_case'),
(10, 'may_assign_case'),
(11, 'may_assign_user_roles'),
(12, 'may_assign_role_privileges'),
(13, 'may_change_all_cases'),
(14, 'may_see_all_cases'),
(15, 'may_export_all_cases'),
(16, 'may_track_all_case_changes'),
(17, 'may_manage_forms'),
(18, 'may_manage_subscriptions'),
(19, 'may_manage_users');
