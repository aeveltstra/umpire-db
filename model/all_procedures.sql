
DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_accept_access_application`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_accept_access_application` (IN `caller_hash` CHAR(128) CHARSET utf8, IN `accepted_email_hash` CHAR(128) CHARSET utf8, OUT `success` BOOLEAN)  MODIFIES SQL DATA
begin 
   declare accepted_user_int int(10) default null;
   declare role_view_own_cases int(10) default null;
   declare is_caller_user_admin bool default false;
   declare amount_of_already_assigned int default 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
       BEGIN
           ROLLBACK;
           RESIGNAL;
       END;
   
   select false into success;
   call `sp_is_user_admin`(caller_hash, is_caller_user_admin);
   if (1 = is_caller_user_admin) then
       select `seq` into accepted_user_int from `users`
         where `email_hash` = accepted_email_hash;
       if (accepted_user_int is not null) THEN
           select `seq` into role_view_own_cases from `user_roles`
             where `name` = 'own_case_viewer';
           if (role_view_own_cases is null) then
             insert into `user_roles` (name) values ('own_case_viewer');
             select `seq` into role_view_own_cases from `user_roles`
               where `name` = 'own_case_viewer';          
           end if;
           select count(*) into amount_of_already_assigned from `user_role_users`
               where `role` = role_view_own_cases
                 and `user` = accepted_user_int;
           if (0 < amount_of_already_assigned) THEN
               select true into success;
           else
               start transaction;
               update `users`
                 set `access_approved_on` = current_timestamp()
                 where `seq` = accepted_user_int;
               insert into `user_role_users` (`role`, `user`)
                 values (role_view_own_cases, accepted_user_int);
               call `sp_log_user_event_by_value`(caller_hash, 'accepted_user_application');
               select true into success;
               commit;
           end if;
       else
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible: access was not requested for that email address.';
       end if;
   else
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Denied: caller lacks user_admin privilege.';
   end if;
END$$

DROP PROCEDURE IF EXISTS `sp_is_user_admin`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_is_user_admin` (IN `user_email_hash` CHAR(128) CHARSET utf8, OUT `result` BOOLEAN)  READS SQL DATA
    DETERMINISTIC
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
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_log_user_event`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_log_user_event` (IN `user` INT(10) UNSIGNED, IN `event` INT(10) UNSIGNED)  begin
insert into `user_events` (`user`, `event`) values (user, event);
END$$

DROP PROCEDURE IF EXISTS `sp_log_user_event_by_value`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_log_user_event_by_value` (IN `user_email_hash` CHAR(128) CHARSET utf8, IN `event_name` VARCHAR(256) CHARSET utf8)  begin
    declare user_int int(10) default null;
    declare event_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is not null) THEN
        select seq into event_int from events where name = event_name;
        if (event_int is null) THEN
            insert into events (name) values (event_name);
            select seq into event_int from events where name = event_name;
        end if;
        if (event_int is not null) THEN
            insert into user_events (user, event) values (user_int, event_int);
        end if;
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_reject_access_application`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_reject_access_application` (IN `caller_hash` CHAR(128) CHARSET utf8, IN `rejected_email_hash` CHAR(128) CHARSET utf8, OUT `success` BOOLEAN)  MODIFIES SQL DATA
begin 
   declare rejected_user_int int(10) default null;
   declare role_view_own_cases int(10) default null;
   declare is_caller_user_admin bool default false;
   declare amount_of_still_assigned int default 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
       BEGIN
           ROLLBACK;
           RESIGNAL;
       END;
   
   select false into success;
   call `sp_is_user_admin`(caller_hash, is_caller_user_admin);
   if (1 = is_caller_user_admin) then
       select `seq` into rejected_user_int from `users`
         where `email_hash` = rejected_email_hash;
       if (rejected_user_int is null) THEN
           select true into success;
       else
           select `seq` into role_view_own_cases from `user_roles`
             where `name` = 'own_case_viewer';
           if (role_view_own_cases is null) then
             insert into `user_roles` (name) values ('own_case_viewer');
             select `seq` into role_view_own_cases from `user_roles`
               where `name` = 'own_case_viewer';          
           end if;
           select count(*) into amount_of_still_assigned from `user_role_users`
               where `role` = role_view_own_cases
                 and `user` = rejected_user_int;
           if (0 = amount_of_still_assigned) THEN
               select true into success;
           else
               start transaction;
               update `users`
                 set `access_approved_on` = NULL
                 where `seq` = rejected_user_int;
               delete from `user_role_users` 
                 where (`role` = role_view_own_cases)
                   and (`user` = rejected_user_int);
               call `sp_log_user_event_by_value`(caller_hash, 'rejected_user_application');
               select true into success;
               commit;
           end if;
       end if;
   else
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Denied: caller lacks user_admin privilege.';
   end if;
end$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_date`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_date` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` DATE, IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into date_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_enumerated`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_enumerated` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` VARCHAR(24), IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into enum_values (at, attribute_id, case_id, user, enum_id) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_integer`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_integer` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` BIGINT(20), IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into integer_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            new_value
        );
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_longtext`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_longtext` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` TEXT CHARSET utf8, IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into longtext_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_shorttext`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_shorttext` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` TINYTEXT CHARSET utf8, IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into shorttext_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_store_time`$$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_store_time` (IN `case_id` BIGINT(20), IN `attribute_id` CHAR(24) CHARSET utf8, IN `new_value` TIME, IN `user_email_hash` CHAR(128) CHARSET utf8)  MODIFIES SQL DATA
begin
    declare user_int int(10) default null;
    select seq into user_int from users where email_hash = user_email_hash;
    if (user_int is null) then
        insert into users (display_name, email_hash, access_requested_on) values ('Anonymous', user_email_hash, now());
        select seq into user_int from users where email_hash = user_email_hash;
    end if;
    if (user_int is not null) THEN
        insert into time_values (at, attribute_id, case_id, user, value) values (
            now(),
            attribute_id,
            case_id,
            user_int,
            nullif(trim(new_value), '')
        );
    end if;
END$$
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
