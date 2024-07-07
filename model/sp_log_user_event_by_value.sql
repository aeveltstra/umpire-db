DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_log_user_event_by_value`$$
CREATE PROCEDURE `sp_log_user_event_by_value`(
    IN `user_email_hash` CHAR(128) CHARSET utf8, 
    IN `event_name` VARCHAR(256) CHARSET utf8
) begin
    declare user_int int(10) default null;
    declare event_int int(10) default null;
    select `seq` into user_int 
        from `users` 
        where `email_hash` = user_email_hash;
    if (user_int is null) then
        call sp_add_anonymous_user(
            user_email_hash, 
            @new_user_id
        ); 
        select @new_user_id into user_int;
    end if;
    if (user_int is not null) THEN
        select `seq` into event_int 
            from `events` 
            where `name` = event_name;
        if (event_int is null) THEN
            insert into `events` (name) 
            values (event_name);
            select `seq` into event_int 
            from `events` 
            where `name` = event_name;
        end if;
        if (event_int is not null) THEN
            call sp_log_user_event(
                user_int, 
                event_int
            );
        end if;
    end if;
END$$
DELIMITER ;