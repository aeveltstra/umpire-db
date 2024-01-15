DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_subscribe`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_subscribe` (
    IN `case_id` BIGINT(20), 
    IN `email` VARCHAR(256) CHARSET utf8,
    OUT `success` BOOLEAN
)  begin
    insert into `subscriptions` (`case_id`, `email`) 
        values (case_id, email);
    select 0 into success;
    select 1 into success from `subscriptions` 
        where `case_id` = case_id
          and `email` = email;
END$$

