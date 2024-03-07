DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_assign_first_case_users`$$
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
        ) values (
            role_view_own_cases,
            user_int
        );
        insert into `entries_roles` (
            `entry`,
            `role`
        ) values (
            entry_id,
            role_view_own_cases
        );
        insert into `entries_roles` (
            `entry`,
            `role`
        ) values (
            entry_id,
            role_case_manager
        );
        commit;
    end if;
END$$
DELIMITER ;