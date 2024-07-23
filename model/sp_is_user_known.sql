DELIMITER $$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_is_user_known`(IN `req_email_hash` VARCHAR(128) CHARSET utf8, IN `req_key_hash` CHAR(128) CHARSET utf8, IN `req_secret_hash` CHAR(128) CHARSET utf8)
    READS SQL DATA
begin

declare previous_attempts int unsigned default 0;
declare found_user int unsigned default 0;
declare amount_of_users_found int unsigned default 0;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

start transaction;

select count(*) into amount_of_users_found 
    from `users` 
    where `email_hash` = req_email_hash;
if (0 = amount_of_users_found) then
  select 0 into previous_attempts;
else 
  select count(*) into previous_attempts
      from `user_events`
      where `user` in (
          select `seq` 
          from `users`
          where `email_hash` = req_email_hash
      )
      and `event` in (
          select `seq`
          from `events`
          where `name` = 'attempted_login'
      )
      and `at` > date_sub(now(), interval 1 day);
end if;

if (5 < previous_attempts) then
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Blocked: too many failed attempts. Try again tomorrow.';
else 
	if (0 < amount_of_users_found) then
    	call `sp_log_user_event_by_value`(
            req_email_hash,
            'attempted_login'
        );
    else
    	call `sp_log_login_attempt_for_unknown_user`(
            req_email_hash,
            req_key_hash,
            req_secret_hash,
            NULL
        );
    end if;
    select
        (count(*) > 0) as `is_known`
        from `users`
        where `email_hash` = req_email_hash
        and `key_hash` = req_key_hash
        and `secret_hash` = req_secret_hash;
end if;

end$$
DELIMITER ;
