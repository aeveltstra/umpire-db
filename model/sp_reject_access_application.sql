DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_reject_access_application`$$
CREATE PROCEDURE `sp_reject_access_application`(IN `caller_hash` CHAR(128) CHARSET utf8, IN `rejected_email_hash` CHAR(128) CHARSET utf8, OUT `success` BOOLEAN)
begin 
   declare rejected_user_int int(10) default null;
   declare role_view_own_cases int(10) default null;
   declare is_caller_user_admin bool default false;
   declare amount_of_still_assigned int default 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
       BEGIN
           ROLLBACK;
           RESIGNAL;
       END;
   
   select false into success;
   call `sp_is_user_admin`(caller_hash, is_caller_user_admin);
   if (1 = is_caller_user_admin) then
       select `seq` into rejected_user_int from `users`
         where `email_hash` = rejected_email_hash;
       if (rejected_user_int is null) THEN
           select true into success;
       else
           select `seq` into role_view_own_cases from `user_roles`
             where `name` = 'own_case_viewer';
           if (role_view_own_cases is null) then
             insert into `user_roles` (name) values ('own_case_viewer');
             select `seq` into role_view_own_cases from `user_roles`
               where `name` = 'own_case_viewer';          
           end if;
           select count(*) into amount_of_still_assigned from `user_role_users`
               where `role` = role_view_own_cases
                 and `user` = rejected_user_int;
           if (0 = amount_of_still_assigned) THEN
               select true into success;
           else
               start transaction;
               update `users`
                 set `access_approved_on` = NULL
                 where `seq` = rejected_user_int;
               delete from `user_role_users` 
                 where (`role` = role_view_own_cases)
                   and (`user` = rejected_user_int);
               call `sp_log_user_event_by_value`(caller_hash, 'rejected_user_application');
               select true into success;
               commit;
           end if;
       end if;
   else
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Denied: caller lacks user_admin privilege.';
   end if;
end$$
DELIMITER ;