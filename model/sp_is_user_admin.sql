DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_is_user_admin`$$
CREATE PROCEDURE `sp_is_user_admin`(IN `user_email_hash` CHAR(128) CHARSET utf8, OUT `result` BOOLEAN)
BEGIN
	DECLARE role_name varchar(48) default 'user_administrator';
    DECLARE role_sec char(10) default '';
	DECLARE user_int int(10) default null;
    select `seq` into role_sec from `user_roles` 
     where `user_roles`.`name` = role_name; 
	if (role_sec is null) then
    	insert into `user_roles` (name) values (role_name);
        select `seq` into role_sec from `user_roles` 
         where `name` = event_name;
    end if;
    select `seq` into user_int from `users` 
     where `email_hash` = user_email_hash;
    if (user_int is null) THEN
    	set result = 0;
    else
    	select (1 <= count(*)) into result from `user_role_users` 
		 where `user` = user_int
		   and `user_role_users`.`role` = role_sec;
	end if;
END$$
DELIMITER ;
