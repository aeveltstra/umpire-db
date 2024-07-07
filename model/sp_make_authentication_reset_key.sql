DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_make_user_auth_reset_key`$$
CREATE PROCEDURE `sp_make_user_auth_reset_key`(
    IN  `user_email_hash` CHAR(128) CHARSET utf8,
    OUT `reset_key_out`   CHAR(128) CHARSET utf8
) begin 
    declare known_user_int int(10) default null;
    select `seq` into known_user_int 
        from `users`
        where `email_hash` = user_email_hash;
    if (known_user_int is not null) THEN
        call sp_log_user_event_by_value(
            user_email_hash, 
            'create_auth_reset_key'
        );
        select UUID() into reset_key_out;
        update `users` 
            set `reset_key_date` = now(),
            `reset_key` = reset_key_out
            where `seq` = known_user_int;
    end if;
END$$
DELIMITER ;