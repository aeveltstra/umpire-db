DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_which_of_these_privileges_does_user_hold`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_which_of_these_privileges_does_user_hold` (IN `user_email_hash` CHAR(128) CHARSET utf8, IN `privileges_csv` VARCHAR(512) CHARSET utf8, OUT `found` VARCHAR(512) CHARSET utf8)  READS SQL DATA
BEGIN

declare user_int int(10) unsigned default null;
declare priv_int int(10) unsigned default null;
declare found_in_set int(10) unsigned default null;
DECLARE done INT DEFAULT FALSE;
declare privileges_ints cursor for select `seq` from `user_privileges`;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

select `seq` into user_int from `users` where `users`.`email_hash` = user_email_hash;
if (user_int is null) THEN
    select null into found;
else
	open privileges_ints;
    read_loop: LOOP
        fetch privileges_ints into priv_int;
        IF done THEN
            LEAVE read_loop;
        END IF;
        set found_in_set := null;
        select find_in_set(priv_int, privileges_csv) into found_in_set;
        if (found_in_set is not null and found_in_set > 0) THEN
        	select concat_ws(',', priv_int, found_in_set) into found;
        end if;
  	END LOOP;
    close privileges_ints;
end if;
END$$

DELIMITER ;
