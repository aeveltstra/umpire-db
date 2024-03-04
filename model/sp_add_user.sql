DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_add_user`$$
CREATE PROCEDURE `sp_add_user`(
    IN  `user_email_hash` CHAR(128)    CHARSET utf8, 
    IN  `key_hash`        char(128)    CHARSET utf8,
    IN  `secret_hash`     char(128)    CHARSET utf8,
    IN  `hashing_algo`    varchar(128) CHARSET utf8,
    IN  `hashing_version` varchar(24)  CHARSET utf8,
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
            `access_requested_on`, 
            `key_hash`, 
            `secret_hash`, 
            `hashing_algo`, 
            `hashing_version`, 
            `last_hashed_date`
        ) values ( 
            user_email_hash,
            now(),
            key_hash,
            secret_hash,
            hashing_algo,
            hashing_version,
            now()
        );
        select last_insert_id() into new_user_id;
    end if;
END$$
DELIMITER ;