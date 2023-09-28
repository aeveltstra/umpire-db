create view `vw_missing_entry_form_attributes` as 
    SELECT a.`id`,
           a.`data_type`, 
           t.`translation` as `caption`, 
           t.`hint`,
           a.`min`,
           a.`max`,
           f.`hide_on_entry`,
           f.`display_sequence`
      FROM `attributes` as a 
     inner join `form_attributes` as f
        on f.`attribute` = a.id
       and f.`form` = 'enter_missing'
     inner join `attribute_translations` as t 
        on t.`attribute_id` = a.`id` 
     where t.`language_code` = 'en'
     order by f.`display_sequence` asc;
