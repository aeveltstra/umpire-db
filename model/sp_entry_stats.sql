DELIMITER $$
CREATE DEFINER=`van`@`10.%` PROCEDURE `sp_entry_stats`(IN `form_id` VARCHAR(128))
    READS SQL DATA
select 
	
	( 
        select count(*) from `entries` 
        where `form` = form_id
    ) as `amount_of_entries`, 
    
    
    ( 
        select count(*) from `form_attributes` 
        where `form` = form_id
    ) as `amount_of_attributes_for_this_form`, 
    
    (
        (select count(*) from `date_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `email_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `enum_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `images` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `integer_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `location_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `longtext_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `shorttext_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
         +
        (select count(*) from `time_values` 
        where `case_id` in ( 
            select `entry_id` from `entries` where `form` = form_id
        ))
    ) as `amount_of_attributes_stored_for_all_entries`,
    
    ROUND(
        (
            (select count(*) from `date_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `email_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `enum_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `images` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `integer_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `location_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `longtext_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `shorttext_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
     		+
            (select count(*) from `time_values` 
            where `case_id` in ( 
                select `entry_id` from `entries` where `form` = form_id
            ))
        ) / (
            select (
            	ifnull((select 1 from (select count(*) as amount from `date_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_dates where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `email_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_emails where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `enum_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_enums where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `images` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_images where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `integer_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_integers where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `location_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_locations where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `longtext_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_longs where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `shorttext_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_shorts where amount > 0),0)
                +
                ifnull((select 1 from (select count(*) as amount from `time_values` 
                where `case_id` in ( 
                    select `entry_id` from `entries` where `form` = form_id
                )) as amount_of_times where amount > 0),0)
            ) * ( 
                    (
                        select count(*) from `entries` 
                        where `form` = `forms`.`id`
                    ) || 1
            )
        )
    ) as `estimated_amount_of_versioned_attributes_per_entry` 
    from `forms` 
    where `id` = form_id$$
DELIMITER ;