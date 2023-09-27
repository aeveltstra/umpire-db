INSERT INTO `attributes` (`id`, `data_type`, `min`, `max`, `default`) VALUES
('aliases', 'shorttext', 0, 256), 
('birth_year', 'integer', 4, 4), 
('birth_year_accuracy', 'percent', 0, 100), 
('case_id', 'shorttext', 1, 256), 
('case_status', 'enum', 1, 256), 
('chosen_name', 'shorttext', 1, 256), 
('contact_if_found', 'longtext', 1, 14400), 
('date_calendar_type', 'enum', 1, 256, 'gregorian'), 
('disappear_circumstances', 'longtext', 1, 65500), 
('entered_by', 'shorttext', 1, 256), 
('entered_on_date', 'date', 8, 8), 
('ethnicity', 'enum', 1, 256, 9), 
('eye_color', 'shorttext', 1, 256), 
('eye_color_std', 'enum', 1, 256), 
('found_on_date', 'date', 8, 8), 
('found_on_date_accuracy', 'percent', 0, 100), 
('given_name', 'shorttext', 1, 256), 
('hair_color', 'shorttext', 1, 256), 
('hair_color_std', 'enum', 1, 256), 
('height', 'integer', 1, 256), 
('height_unit', 'enum', 1, 256), 
('identifying_features', 'longtext', 1, 65500), 
('last_modified_by', 'enum', 1, 256), 
('last_modified_on_date', 'date', 8, 8), 
('last_seen_activity', 'longtext', 1, 65500), 
('last_seen_alive_date_acc', 'percent', 0, 100), 
('last_seen_alive_on_date', 'date', 8, 8), 
('last_seen_at_location', 'shorttext', 1, 256), 
('last_seen_date_accuracy', 'percent', 0, 100), 
('last_seen_on_date', 'date', 8, 8), 
('last_seen_wearing', 'longtext', 1, 65500), 
('other_notes', 'longtext', 1, 65500), 
('posters_generated_on', 'date', 8, 8), 
('pronouns', 'shorttext', 1, 256), 
('weight', 'integer', 1, 256), 
('weight_unit', 'enum', 1, 256);
