DROP TABLE IF EXISTS `vw_get_privileges_for_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`van`@`10.%` SQL SECURITY DEFINER VIEW `vw_get_privileges_for_user`  AS  select distinct `user_role_users`.`user` AS `user`,`user_privileges`.`name` AS `privilege` from ((`user_privileges` join `user_role_privileges` on((`user_role_privileges`.`privilege` = `user_privileges`.`seq`))) join `user_role_users` on((`user_role_users`.`role` = `user_role_privileges`.`role`))) ;
