CREATE TABLE `enum_values` (
  `attribute_id` char(24) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `enum_id` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerated values for enumerated attributes: a single choice from multiple. Useful for standardized nouns like hair color and units of measurement.';