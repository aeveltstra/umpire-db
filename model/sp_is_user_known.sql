DELIMITER $$
CREATE PROCEDURE `sp_is_user_known`(
    IN `req_email_hash` VARCHAR(128) CHARSET utf8, 
    IN `req_key_hash` CHAR(128) CHARSET utf8, 
    IN `req_secret_hash` CHAR(128) CHARSET utf8
) READS SQL DATA 
select
    (count(*) > 0) as `is_known`
    from `users`
    where `email_hash` = req_email_hash
    and `key_hash` = req_key_hash
    and `secret_hash` = req_secret_hash$$
DELIMITER ;