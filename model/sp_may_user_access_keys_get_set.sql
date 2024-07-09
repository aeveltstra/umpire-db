DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_may_user_access_keys_get_set`$$
CREATE PROCEDURE `sp_may_user_access_keys_get_set`(
    IN  `user_email_hash` CHAR(128) CHARSET utf8
) begin

    declare is_less_than_3_per_hour int(1) default 0;
    declare is_longer_than_1_minute_ago int(1) default 0;
    declare user_int int(10) default null;

    select `seq` into user_int
        from `users`
        where `email_hash` = user_email_hash;

    select (count(`seq`) < 3) into is_less_than_3_per_hour
        from `user_events`
        where `user` = user_int
        and `event` = (
            select `seq`
                from `events`
                where `name` = 'set_user_auth'
        )
        and `at` > (
            date_sub(now(), INTERVAL 1 HOUR)
        );
    
    select (count(`seq`) = 0) into is_longer_than_1_minute_ago
        from `user_events`
        where `user` = user_int
        and `event` = (
            select `seq`
                from `events`
                where `name` = 'set_user_auth'
        )
        and `at` > (
            date_sub(now(), INTERVAL 1 MINUTE)
        );
    
    select (is_less_than_3_per_hour = 1) 
        and (is_longer_than_1_minute_ago = 1) 
        and user_int is not null
        as is_allowed;
end$$
DELIMITER ;
