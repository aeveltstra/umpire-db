DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_store_access_keys_if_allowed`$$
CREATE PROCEDURE `sp_store_access_keys_if_allowed`(
    IN `challenger_email_hash` CHAR(128) CHARSET utf8,
    IN `challenger_reset_key` char(128) CHARSET utf8,
    IN `new_key_hash` char(128) CHARSET utf8,
    IN `new_secret_hash` char(128) CHARSET utf8
) begin 

    set @test1 = call sp_may_user_reset_own_authentication(challenger_email_hash);
    set @test2 = call sp_may_user_access_keys_get_set(challenger_email_hash);
    select 1 into @test3 from `users` 
        where `email_hash` = challenger_email_hash
        and `reset_key` = challenger_reset_key
        and `reset_key_date` > date_sub(now(), INTERVAL 1 HOUR);
    
    set @all_passed = (@test1 = 1) and (@test2 = 1) and (@test3 = 1);
    if (@all_passed = 1) then
        call sp_log_user_event_by_value(
            challenger_email_hash,
            'set_user_auth'
        );
        update `users` 
        set `key_hash` = new_key_hash,
            `secret_hash` = new_secret_hash,
            `reset_key` = null,
            `reset_key_date` = null
        where `email_hash` = challenger_email_hash
        and `reset_key` = `challenger_reset_key`;
        select 1 as got_stored;
    else
        select 0 as got_stored;
    end if;

end$$
DELIMITER ;