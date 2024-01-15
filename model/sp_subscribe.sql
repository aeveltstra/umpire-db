DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_subscribe`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_subscribe` (
    IN `case_id` BIGINT(20), 
    IN `email` VARCHAR(256) CHARSET utf8,
    OUT `success` BOOLEAN
)  begin
    declare amount_existing int default 0;
    select 0 into success;
    select count(*) into amount_existing 
        from `subscriptions` 
        where `case_id` = case_id
          and `email` = email;
    if (0 = amount_existing) then
        insert into `subscriptions` (`case_id`, `email`) 
            values (case_id, email);
        select count(*) into amount_existing 
            from `subscriptions` 
            where `case_id` = case_id
              and `email` = email;
        if (0 < amount_existing) then
            select 1 into success;
        end if;
    else
        select 1 into success;
    end if;
END$$

