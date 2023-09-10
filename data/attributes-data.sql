/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

INSERT INTO `attributes` (`id`, `data_type`, `min`, `max`, `default`, `read_only`, `use_for`) VALUES
('aliases', 'shorttext', 0, 256, '', 0, 'any'),
('birth year', 'integer', 4, 4, '', 0, 'any'),
('birth year accuracy', 'percent', 0, 100, '', 0, 'any'),
('case id', 'shorttext', 1, 256, '', 1, 'any'),
('case status', 'enum', 1, 256, '', 0, 'any'),
('chosen name', 'shorttext', 1, 256, '', 0, 'any'),
('contact if found', 'longtext', 1, 14400, '', 0, 'any'),
('date calendar type', 'enum', 1, 256, '', 0, 'any'),
('disappear circumstances', 'longtext', 1, 65500, '', 0, 'any'),
('entered by', 'shorttext', 1, 256, '', 0, 'any'),
('entered on date', 'date', 8, 8, '', 1, 'any'),
('ethnicity', 'enum', 1, 256, '', 0, 'any'),
('eye color', 'shorttext', 1, 256, '', 0, 'any'),
('eye color std', 'enum', 1, 256, '', 0, 'any'),
('found on date', 'date', 8, 8, '', 0, 'unidentified_people'),
('found on date accuracy', 'percent', 0, 100, '', 0, 'unidentified_people'),
('given name', 'shorttext', 1, 256, '', 0, 'any'),
('hair color', 'shorttext', 1, 256, '', 0, 'any'),
('hair color std', 'enum', 1, 256, '', 0, 'any'),
('height', 'integer', 1, 256, '', 0, 'any'),
('height unit', 'enum', 1, 256, '', 0, 'any'),
('identifying features', 'longtext', 1, 65500, '', 0, 'any'),
('last modified by', 'enum', 1, 256, '', 1, 'any'),
('last modified on date', 'date', 8, 8, '', 1, 'any'),
('last seen activity', 'longtext', 1, 65500, '', 0, 'any'),
('last seen alive date acc', 'percent', 0, 100, '', 0, 'unidentified_people'),
('last seen alive on date', 'date', 8, 8, '', 0, 'unidentified_people'),
('last seen at location', 'shorttext', 1, 256, '', 0, 'any'),
('last seen date accuracy', 'percent', 0, 100, '', 0, 'missing_people'),
('last seen on date', 'date', 8, 8, '', 0, 'missing_people'),
('last seen wearing', 'longtext', 1, 65500, '', 0, 'any'),
('other notes', 'longtext', 1, 65500, '', 0, 'any'),
('posters generated on', 'date', 8, 8, '', 0, 'any'),
('pronouns', 'shorttext', 1, 256, '', 0, 'any'),
('weight', 'integer', 1, 256, '', 0, 'any'),
('weight unit', 'enum', 1, 256, '', 0, 'any');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
