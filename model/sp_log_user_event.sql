DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_log_user_event`$$
CREATE PROCEDURE `sp_log_user_event` (
    IN `user` INT(10) UNSIGNED, 
    IN `event` INT(10) UNSIGNED
) begin
    insert into `user_events` (`user`, `event`) 
    values (user, event);
END$$

DELIMITER ;