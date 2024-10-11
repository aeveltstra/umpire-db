DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_image`$$

CREATE PROCEDURE `sp_store_image`(
    IN `case_id` BIGINT(20), 
    IN `attribute_id` CHAR(24) CHARSET utf8, 
    IN `new_url` VARCHAR(512) CHARSET utf8, 
    IN `user_email_hash` CHAR(128) CHARSET utf8,
    IN `alt` VARCHAR(256) CHARSET utf8,
    IN `descr` VARCHAR(1024) CHARSET utf8,
    IN `is_public` TINYINT UNSIGNED
)
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        call sp_add_anonymous_user(user_email_hash, @new_user_id); 
        select @new_user_id into user_int;
    end if;
    if (user_int is not null) THEN
        insert into images (at, attribute_id, case_id, user, url, alt, description, is_public) 
        values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_url), ''),
            nullif(trim(alt), ''),
            nullif(trim(descr), ''),
            is_public
        );
    end if;
END$$
DELIMITER ;
