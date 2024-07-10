DELIMITER $$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_may_user_reset_own_authentication_2`(IN `user_email_hash` CHAR(128) CHARSET utf8, OUT `is_allowed` INT)
    READS SQL DATA
begin
select (count(`seq`) < 5) into is_allowed
        from `user_events`
        where `user` = (
            select `seq`
                from `users`
                where `email_hash` = user_email_hash
        )
        and `event` = (
            select `seq`
                from `events`
                where `name` = 'create_auth_reset_key'
        )
        and `at` > (
            date_sub(now(), INTERVAL 1 DAY)
        );
	select is_allowed;
END$$
DELIMITER ;