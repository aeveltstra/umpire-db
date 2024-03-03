TRUNCATE TABLE `enums`;

INSERT INTO `enums` (`attribute_id`, `enum_value`, `language_code`, `caption`) VALUES
('case_status', 'solved', 'en', 'Solved'),
('case_status', 'unsolved', 'en', 'Unsolved'),
('ethnicity', '1', 'en', 'White'),
('ethnicity', '2', 'en', 'Black or African American'),
('ethnicity', '3', 'en', 'Hispanic or Latino'),
('ethnicity', '4', 'en', 'Asian'),
('ethnicity', '5', 'en', 'American Indian or Alaska Native'),
('ethnicity', '7', 'en', 'Native Hawaiian or Other Pacific Islander'),
('ethnicity', '9', 'en', 'Other'),
('ethnicity', 'unknown', 'en', 'Unknown'),
('eye_color_std', 'black', 'en', 'Black'),
('eye_color_std', 'blue', 'en', 'Blue'),
('eye_color_std', 'brown', 'en', 'Brown'),
('eye_color_std', 'green', 'en', 'Green'),
('eye_color_std', 'grey', 'en', 'Grey'),
('eye_color_std', 'hazel', 'en', 'Hazel'),
('eye_color_std', 'multiple', 'en', 'Multiple'),
('eye_color_std', 'red', 'en', 'Red'),
('eye_color_std', 'unknown', 'en', 'Unknown'),
('hair_color_std', 'black', 'en', 'Black'),
('hair_color_std', 'blonde', 'en', 'Blonde'),
('hair_color_std', 'blue', 'en', 'Blue'),
('hair_color_std', 'brown', 'en', 'Brown'),
('hair_color_std', 'dirty blonde', 'en', 'Dirty Blonde'),
('hair_color_std', 'ginger', 'en', 'Ginger / Red'),
('hair_color_std', 'green', 'en', 'Green'),
('hair_color_std', 'grey', 'en', 'Grey'),
('hair_color_std', 'multiple', 'en', 'Multiple'),
('hair_color_std', 'pink', 'en', 'Pink'),
('hair_color_std', 'platinum', 'en', 'Platinum'),
('hair_color_std', 'purple', 'en', 'Purple'),
('hair_color_std', 'red', 'en', 'Red'),
('hair_color_std', 'unknown', 'en', 'Unknown'),
('hair_color_std', 'white', 'en', 'White'),
('height_unit', 'centimeter', 'en', 'Centimeter'),
('height_unit', 'inches', 'en', 'Inches'),
('weight_unit', 'kilograms', 'en', 'Kilograms'),
('weight_unit', 'lbs', 'en', 'Pounds');
