DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_enumerated`$$
CREATE PROCEDURE `sp_store_enumerated`(
    IN `case_id` BIGINT(20), 
    IN `attribute_id` CHAR(24) CHARSET utf8, 
    IN `new_value` VARCHAR(24), 
    IN `user_email_hash` CHAR(128) CHARSET utf8)
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        call sp_add_anonymous_user(user_email_hash, @new_user_id); 
        select @new_user_id into user_int;
    end if;
    if (user_int is not null) THEN
        insert into enum_values (at, attribute_id, case_id, user, value) 
        values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
DELIMITER ;