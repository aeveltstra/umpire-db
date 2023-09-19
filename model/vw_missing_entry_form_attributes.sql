create view `vw_missing_entry_form_attributes` as 
    SELECT a.`id` as `$id`, 
           a.`data_type`, 
           t.`translation` as `$caption`, 
           t.`hint` as `$hint`, 
           a.`min` as `$min`, 
           a.`max` as `$max`,
           f.`display_sequence`,
           f.`hide_on_entry` as `$hide_on_entry`
      FROM `attributes` as a 
     inner join `form_attributes` as f
        on f.`attribute` = a.id
       and f.`form` = 'enter_missing'
     inner join `attribute_translations` as t 
        on t.`attribute_id` = a.`id` 
     where t.`language_code` = 'en'
     order by f.`display_sequence` asc;
