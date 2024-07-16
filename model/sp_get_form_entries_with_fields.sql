DELIMITER $$
CREATE PROCEDURE `sp_get_form_entries_with_fields`(
	IN `form_name` VARCHAR(128) CHARSET utf8, 
	IN `display_lang` VARCHAR(3) CHARSET utf8
) READS SQL DATA DETERMINISTIC
select * from (
    select entry_id, display_sequence, data_type, form_attributes.attribute, epoch as value, at, user 
        from date_values 
        inner join form_attributes on form_attributes.attribute = date_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id
        and entries.form = form_name
        inner join attributes on attributes.id = date_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from email_values 
        inner join form_attributes on form_attributes.attribute = email_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = email_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from integer_values 
        inner join form_attributes on form_attributes.attribute = integer_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = integer_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, x as value, at, user 
        from location_values 
        inner join form_attributes on form_attributes.attribute = location_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = location_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from longtext_values 
        inner join form_attributes on form_attributes.attribute = longtext_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = longtext_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from shorttext_values 
        inner join form_attributes on form_attributes.attribute = shorttext_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = shorttext_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from time_values 
        inner join form_attributes on form_attributes.attribute = time_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = time_values.attribute_id
    UNION
    select entry_id, display_sequence, data_type, form_attributes.attribute, value, at, user 
        from enum_values 
        inner join form_attributes on form_attributes.attribute = enum_values.attribute_id 
        inner join forms on forms.id = form_attributes.form
        inner join entries on entries.form = forms.id 
        and entries.form = form_name
        inner join attributes on attributes.id = enum_values.attribute_id
) as them
order by entry_id, display_sequence
$$
DELIMITER ;
