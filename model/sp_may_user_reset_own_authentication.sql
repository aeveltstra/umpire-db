DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_may_user_reset_own_authentication`$$
CREATE PROCEDURE `sp_may_user_reset_own_authentication`(
    IN  `user_email_hash` CHAR(128) CHARSET utf8
) READS SQL DATA  
    select (count(`seq`) < 5) 
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
        )
$$
DELIMITER ;
