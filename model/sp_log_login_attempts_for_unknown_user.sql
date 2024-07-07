DELIMITER $$
CREATE PROCEDURE `sp_log_login_attempt_for_unknown_user`(
    IN `email_hash` CHAR(128) CHARSET utf8 DEFAULT NULL, 
    IN `key_hash` CHAR(128) CHARSET utf8 DEFAULT NULL, 
    IN `secret_hash` CHAR(128) CHARSET utf8 DEFAULT NULL, 
    IN `browser_fingerprint` VARCHAR(512) CHARSET utf8 DEFAULT NULL
) MODIFIES SQL DATA
insert into `login_attempts_for_unknown_users` (
    `email_hash`,
    `key_hash`,
	`secret_hash`,
	`browser_fingerprint`
) values (
    email_hash,
    key_hash,
	secret_hash,
	browser_fingerprint
)$$
DELIMITER ;