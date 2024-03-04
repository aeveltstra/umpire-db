DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_add_anonyous_user`$$
CREATE PROCEDURE `sp_add_anonymous_user`(
    IN  `user_email_hash` CHAR(128)    CHARSET utf8,
    OUT `new_user_id`     int(10)      UNSIGNED
) begin 
    declare known_user_int int(10) default null;
   
    select `seq` into known_user_int 
    from `users`
    where `email_hash` = user_email_hash;
    if (known_user_int is not null) THEN
        select known_user_int into new_user_id;
    else
        insert into `users` (
            `email_hash`, 
            `display_name`
        ) values ( 
            user_email_hash,
            'Anonymous'
        );
        select last_insert_id() into new_user_id;
    end if;
END$$
DELIMITER ;