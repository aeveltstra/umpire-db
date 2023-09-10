/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE TABLE `attributes` (
  `id` char(24) NOT NULL,
  `data_type` enum('integer','shorttext','longtext','date','time','enum','percent') CHARACTER SET ascii NOT NULL,
  `min` int(11) NOT NULL DEFAULT '0',
  `max` int(11) NOT NULL DEFAULT '256',
  `default` varchar(256) NOT NULL,
  `read_only` tinyint(1) NOT NULL DEFAULT '0',
  `use_for` enum('missing_people','unidentified_people','any','') NOT NULL DEFAULT 'any'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Enumerate text attributes';

ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_type` (`data_type`),
  ADD KEY `ix_use_for` (`use_for`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
