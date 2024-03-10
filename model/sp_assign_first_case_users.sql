DELIMITER $$
CREATE PROCEDURE `sp_assign_first_case_users`(
    IN `entry_id` BIGINT(20), 
    IN `user_email_hash` CHAR(128) CHARSET utf8
) begin
    declare user_int int(10) default null;
    declare role_view_own_cases int(10) default null;
    declare role_case_manager int(10) default null;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    start transaction;

    select seq into user_int 
    from users 
    where email_hash = user_email_hash;
    if (user_int is null) THEN
        call sp_add_anonymous_user(user_email_hash, @new_user_id); 
        select @new_user_id into user_int;
        if (user_int is null) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible: failed to add anonymous user.';
        end if;
    else 
        select `seq` into role_view_own_cases from `user_roles`
        where `name` = 'own_case_viewer';
        if (role_view_own_cases is null) then
            insert into `user_roles` (name) 
            values ('own_case_viewer');
            select `seq` into role_view_own_cases 
            from `user_roles`
            where `name` = 'own_case_viewer';          
        end if;
        if (role_view_own_cases is null) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible: failed to locate required user role: own_case_viewer.';
        end if;
        select `seq` into role_case_manager from `user_roles`
        where `name` = 'case_manager';
        if (role_case_manager is null) then
            insert into `user_roles` (name) 
            values ('case_manager');
            select `seq` into role_case_manager 
            from `user_roles`
            where `name` = 'case_manager';          
        end if;
        if (role_case_manager is null) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible: failed to locate required user role: case_manager.';
        end if;
        insert into `user_role_users` (
            `role`,
            `user`
        ) select * from (select
            role_view_own_cases as `role`,
            user_int as `user`
        ) as new_value where not exists (
            select 1 from `user_role_users`
            where `role` = role_view_own_cases
            and `user` = user_int
        ) limit 1;
        insert into `entries_roles` (
            `entry`,
            `role`
        ) select * from (select 
            entry_id as `entry`,
            role_view_own_cases as `role`
        ) as new_value where not exists (
            select 1 from `entries_roles`
            where `role` = role_view_own_cases
            and `entry` = entry_id
        ) limit 1;
        insert into `entries_roles` (
            `entry`,
            `role`
        ) select * from (select 
            entry_id as `entry`,
            role_case_manager as `role`
        ) as new_value where not exists (
            select 1 from `entries_roles`
            where `role` = role_case_manager
            and `entry` = entry_id
        ) limit 1;
        commit;
    end if;
END$$
DELIMITER ;