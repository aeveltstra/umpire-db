DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_location`$$
CREATE PROCEDURE `sp_store_location`(
    IN `case_id` BIGINT(20), 
    IN `attribute_id` CHAR(24) CHARSET utf8, 
    IN `x` smallint,
    IN `x_decimals` mediumint,
    IN `x_sign` tinyint,
    IN `y` smallint,
    IN `y_decimals` mediumint,
    IN `y_sign` tinyint,
    IN `z` smallint,
    IN `z_decimals` mediumint,
    IN `z_sign` tinyint,
    IN `user_email_hash` CHAR(128) CHARSET utf8
)
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into location_values (
            at, 
            attribute_id, 
            case_id, 
            user, 
            x,
            x_decimals,
            x_sign,
            y,
            y_decimals,
            y_sign,
            z,
            z_decimals,
            z_sign
        ) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            x,
            x_decimals,
            x_sign,
            y,
            y_decimals,
            y_sign,
            z,
            z_decimals,
            z_sign
        );
    end if;
END$$
DELIMITER ;