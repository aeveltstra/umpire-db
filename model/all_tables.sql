DROP TABLE IF EXISTS users;
CREATE TABLE users (
 seq int(10) unsigned NOT NULL AUTO_INCREMENT,
 email_hash char(128) NOT NULL,
 display_name varchar(256) DEFAULT NULL,
 access_requested_on date DEFAULT NULL,
 access_approved_on date DEFAULT NULL,
 key_hash char(128) DEFAULT NULL,
 secret_hash char(128) DEFAULT NULL,
 hashing_algo varchar(128) DEFAULT NULL,
 hashing_version varchar(24) DEFAULT NULL,
 last_hashed_date date DEFAULT NULL,
 reset_key char(128) DEFAULT NULL,
 reset_key_date date DEFAULT NULL,
 PRIMARY KEY (seq),
 UNIQUE KEY email_hash_ix (email_hash),
 KEY token (key_hash,secret_hash),
 KEY hashing (hashing_algo,hashing_version),
 KEY last_hashed (last_hashed_date),
 KEY access_requested_on (access_requested_on),
 KEY reset_key (reset_key)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='People allowed to use the system';

DROP TABLE IF EXISTS user_privileges;
CREATE TABLE user_privileges (
 seq int(10) unsigned NOT NULL AUTO_INCREMENT,
 name varchar(48) NOT NULL,
 PRIMARY KEY (seq),
 UNIQUE KEY user_privilege_name (name)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='What actions users are allowed to perform';

DROP TABLE IF EXISTS user_roles;
CREATE TABLE user_roles (
 seq int(10) unsigned NOT NULL AUTO_INCREMENT,
 name varchar(48) NOT NULL,
 UNIQUE KEY seq (seq),
 UNIQUE KEY user_role_name (name)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Determines what users can do';

DROP TABLE IF EXISTS events;
CREATE TABLE events (
 seq int(10) unsigned NOT NULL AUTO_INCREMENT,
 name varchar(256) NOT NULL,
 PRIMARY KEY (seq)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Actions taken by users, registered for audits';

DROP TABLE IF EXISTS forms;
CREATE TABLE forms (
 id char(24) NOT NULL,
 PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;

DROP TABLE IF EXISTS language_codes;
CREATE TABLE language_codes (
 code varchar(24) NOT NULL,
 PRIMARY KEY (code)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Codes for languages. Follow ISO 639-2 as defined by BCP 47.';

DROP TABLE IF EXISTS attributes;
CREATE TABLE attributes (
  `id` char(24) NOT NULL,
  `data_type` enum('integer','shorttext','longtext','date','time','enum','percent') CHARACTER SET ascii NOT NULL,
  `min` int(11) NOT NULL DEFAULT '0',
  `max` int(11) NOT NULL DEFAULT '256',
  `default` varchar(256) NOT NULL,
  `is_write_once` tinyint(1) NOT NULL,
  PRIMARY KEY (id),
  KEY ix_attribute_is_write_once (is_write_once),
  KEY ix_data_type (data_type) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerate text attributes';

DROP TABLE IF EXISTS images;
CREATE TABLE images (
 id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'just a sequence nr.',
 case_id varchar(24) NOT NULL,
 is_public tinyint(1) NOT NULL,
 url varchar(512) NOT NULL,
 PRIMARY KEY (id),
 KEY case_id (case_id),
 KEY ix_img_is_public (is_public)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Public and private media';

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
 case_id bigint(20) NOT NULL AUTO_INCREMENT,
 added_on datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
 form char(24) CHARACTER SET ascii NOT NULL,
 PRIMARY KEY (case_id),
 KEY ix_profiles_form (form) USING BTREE,
 CONSTRAINT fk_profiles_form FOREIGN KEY (form) REFERENCES forms (id)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Cases of missing and unidentified people';

DROP TABLE IF EXISTS attribute_translations;
CREATE TABLE attribute_translations (
  language_code varchar(24) CHARACTER SET ascii NOT NULL,
  attribute_id char(24) NOT NULL,
  translation text NOT NULL,
  hint tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (language_code,attribute_id),
  KEY fk_attrib_id (attribute_id),
  CONSTRAINT fk_attrib_id FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_lang_code FOREIGN KEY (language_code) REFERENCES language_codes (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations of attribute captions';

DROP TABLE IF EXISTS date_values;
CREATE TABLE date_values (
  attribute_id char(24) NOT NULL,
  case_id bigint(20) NOT NULL,
  value date NOT NULL,
  user int(10) unsigned NOT NULL,
  at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (attribute_id,case_id,at) USING BTREE,
  KEY value (value),
  KEY ix_date_values_user (user),
  KEY ix_date_values_modified (at),
  KEY ix_date_values_case (case_id) USING BTREE,
  CONSTRAINT fk_dates_attribute FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_dates_case FOREIGN KEY (case_id) REFERENCES profiles (case_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for date attributes';

DROP TABLE IF EXISTS enums;
CREATE TABLE enums (
 attribute_id char(24) NOT NULL,
 enum_value varchar(24) NOT NULL,
 language_code varchar(24) CHARACTER SET ascii NOT NULL,
 caption varchar(256) NOT NULL,
 PRIMARY KEY (attribute_id,enum_value,language_code) USING BTREE,
 KEY ix_lang (language_code),
 KEY ix_attrib (attribute_id) USING BTREE,
 KEY ix_enum_value (enum_value) USING BTREE,
 CONSTRAINT fk_enums_attrib_attributes FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_enums_lang_languages FOREIGN KEY (language_code) REFERENCES language_codes (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All possible enumerations for all attributes';

DROP TABLE IF EXISTS enum_values;
CREATE TABLE enum_values (
  attribute_id char(24) NOT NULL,
  case_id bigint(20) NOT NULL,
  enum_id varchar(24) NOT NULL,
  PRIMARY KEY (attribute_id,case_id),
  KEY enum_values_case_ids (case_id),
  KEY enum_values_enum_ids (enum_id),
  CONSTRAINT fk_attrib_id_enum_values FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_case_id_enum_values FOREIGN KEY (case_id) REFERENCES profiles (case_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_enum_id_enum_values FOREIGN KEY (enum_id) REFERENCES enums (enum_value) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerated values for enumerated attributes: a single choice from multiple. Useful for standardized nouns like hair color and units of measurement.';

DROP TABLE IF EXISTS form_attributes;
CREATE TABLE form_attributes (
 form char(24) NOT NULL,
 attribute char(24) CHARACTER SET utf8 NOT NULL,
 display_sequence smallint(5) unsigned NOT NULL,
 hide_on_entry tinyint(1) NOT NULL DEFAULT '0',
 UNIQUE KEY pk_form_form_attribute (form,attribute),
 KEY ix_form_form (form),
 KEY ix_form_display_seq (display_sequence),
 KEY ix_hide_on_entry (hide_on_entry),
 KEY fk_form_attrib_attribs_id (attribute) USING BTREE,
 CONSTRAINT fk_form_attrib_attribs_id FOREIGN KEY (attribute) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_form_form_forms_id FOREIGN KEY (form) REFERENCES forms (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Which attributes go on which form, in which order?';

DROP TABLE IF EXISTS form_caption_translations;
CREATE TABLE form_caption_translations (
 form char(24) CHARACTER SET ascii NOT NULL,
 language varchar(24) CHARACTER SET ascii NOT NULL,
 caption varchar(256) NOT NULL,
 PRIMARY KEY (form,language),
 KEY fk_form_captions_language (language),
 CONSTRAINT fk_form_captions_form FOREIGN KEY (form) REFERENCES forms (id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_form_captions_language FOREIGN KEY (language) REFERENCES language_codes (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations for display captions for forms';

DROP TABLE IF EXISTS integer_values;
CREATE TABLE integer_values (
 attribute_id char(24) NOT NULL,
 case_id bigint(20) NOT NULL,
 value bigint(20) NOT NULL,
 user int(10) unsigned NOT NULL,
 at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (attribute_id,case_id,at) USING BTREE,
 KEY ix_integer_values_modified (at) USING BTREE,
 KEY ix_integer_values_user (user) USING BTREE,
 KEY ix_integers_case (case_id) USING BTREE,
 CONSTRAINT fk_integer_values_attribute FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_integer_values_case FOREIGN KEY (case_id) REFERENCES profiles (case_id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_integer_values_user FOREIGN KEY (user) REFERENCES users (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for text attributes';

DROP TABLE IF EXISTS longtext_values;
CREATE TABLE longtext_values (
 attribute_id char(24) NOT NULL,
 case_id bigint(20) NOT NULL,
 value text NOT NULL,
 user int(10) unsigned NOT NULL,
 at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (attribute_id,case_id,at) USING BTREE,
 KEY ix_longtext_values_case (case_id) USING BTREE,
 KEY ix_longtext_values_user (user) USING BTREE,
 KEY ix_longtext_values_modified (at) USING BTREE,
 FULLTEXT KEY ix_longtext_values_fulltext (value),
 CONSTRAINT fk_4 FOREIGN KEY (case_id) REFERENCES profiles (case_id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_8 FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Huge values for text attributes. Think reports, DNA kits, family trees.';

DROP TABLE IF EXISTS shorttext_values;
CREATE TABLE shorttext_values (
 attribute_id char(24) NOT NULL,
 case_id bigint(20) NOT NULL,
 value tinytext NOT NULL,
 user int(10) unsigned NOT NULL,
 at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (attribute_id,case_id),
 KEY ix_date_values_user (user),
 KEY ix_date_values_modified (at),
 KEY ix_date_values_case_id (case_id) USING BTREE,
 FULLTEXT KEY ix_dates_value_fulltext (value),
 CONSTRAINT fk_dates_user FOREIGN KEY (user) REFERENCES users (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Short values for text attributes: less than 256 characters. Useful for names and places.';

DROP TABLE IF EXISTS time_values;
CREATE TABLE time_values (
 attribute_id char(24) NOT NULL,
 case_id bigint(20) NOT NULL,
 value time NOT NULL,
 user int(10) unsigned NOT NULL,
 at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (attribute_id,case_id),
 KEY fk_case_id (case_id),
 KEY value (value),
 KEY ix_date_values_user (user),
 KEY ix_date_values_modified (at),
 CONSTRAINT fk_2 FOREIGN KEY (case_id) REFERENCES profiles (case_id) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_9 FOREIGN KEY (attribute_id) REFERENCES attributes (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Values for time and date attributes';

DROP TABLE IF EXISTS user_events;
CREATE TABLE user_events (
 seq int(10) unsigned NOT NULL AUTO_INCREMENT,
 user int(10) unsigned NOT NULL,
 event int(10) unsigned NOT NULL,
 at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (seq),
 KEY ix_user_events_at_datetime (at),
 KEY fk_user_events_event (event),
 KEY fk_user_events_user (user),
 CONSTRAINT fk_user_events_event FOREIGN KEY (event) REFERENCES events (seq) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_user_events_user FOREIGN KEY (user) REFERENCES users (seq) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=binary COMMENT='When which user took which action';

DROP TABLE IF EXISTS user_role_privileges;
CREATE TABLE user_role_privileges (
 role int(10) unsigned NOT NULL,
 privilege int(10) unsigned NOT NULL,
 PRIMARY KEY (role,privilege),
 KEY fk_user_role_privileges_privilege (privilege),
 CONSTRAINT fk_user_role_privileges_privilege FOREIGN KEY (privilege) REFERENCES user_privileges (seq) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_user_role_privileges_role FOREIGN KEY (role) REFERENCES user_roles (seq) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns actions to user roles';

DROP TABLE IF EXISTS user_role_users;
CREATE TABLE user_role_users (
 role int(10) unsigned NOT NULL,
 user int(10) unsigned NOT NULL,
 PRIMARY KEY (role,user),
 KEY fk_user_role_users_user (user),
 CONSTRAINT fk_user_role_users_role FOREIGN KEY (role) REFERENCES user_roles (seq) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_user_role_users_user FOREIGN KEY (user) REFERENCES users (seq) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=binary COMMENT='Assigns users to user roles';
