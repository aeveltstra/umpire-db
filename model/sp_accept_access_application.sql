DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_accept_access_application`$$
CREATE PROCEDURE `sp_accept_access_application`(
  IN `caller_hash` CHAR(128) CHARSET utf8, 
  IN `accepted_email_hash` CHAR(128) CHARSET utf8, 
  OUT `success` BOOLEAN
) begin 
   declare accepted_user_int int(10) default null;
   declare role_view_own_cases int(10) default null;
   declare is_caller_user_admin bool default false;
   declare amount_of_already_assigned int default 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
       BEGIN
           ROLLBACK;
           RESIGNAL;
       END;
   
   select false into success;
   call `sp_is_user_admin`(caller_hash, is_caller_user_admin);
   if (1 = is_caller_user_admin) then
       select `seq` into accepted_user_int from `users`
         where `email_hash` = accepted_email_hash;
       if (accepted_user_int is not null) THEN
           select `seq` into role_view_own_cases 
              from `user_roles`
              where `name` = 'own_case_viewer';
           if (role_view_own_cases is null) then
             insert into `user_roles` (name) 
             values ('own_case_viewer');
             select `seq` into role_view_own_cases 
             from `user_roles`
             where `name` = 'own_case_viewer';          
           end if;
           select count(*) into amount_of_already_assigned from `user_role_users`
               where `role` = role_view_own_cases
                 and `user` = accepted_user_int;
           if (0 < amount_of_already_assigned) THEN
               select true into success;
           else
               start transaction;
               update `users`
                 set `access_approved_on` = current_timestamp()
                 where `seq` = accepted_user_int;
               insert into `user_role_users` (`role`, `user`)
                 values (role_view_own_cases, accepted_user_int);
               call `sp_log_user_event_by_value`(caller_hash, 'accepted_user_application');
               select true into success;
               commit;
           end if;
       else
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible: access was not requested for that email address.';
       end if;
   else
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Denied: caller lacks user_admin privilege.';
   end if;
END$$
DELIMITER ;