DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_time`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_time` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` TIME, IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into time_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
