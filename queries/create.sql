CREATE SCHEMA if not exists airport;

CREATE TABLE `airport`.`flight` (
  `id_flight` INT NOT NULL AUTO_INCREMENT,
  `company` CHAR(2) NOT NULL,
  `number` SMALLINT(4) UNSIGNED NOT NULL,
  `destination` CHAR(3) NOT NULL,
  `frequency` INT NOT NULL,
  PRIMARY KEY (`id_flight`)
);

CREATE TABLE `airport`.`frequency` (
  `id_frequency` INT NOT NULL AUTO_INCREMENT,
  `begin` DATE NULL,
  `end` DATE NULL,
  `days` TINYINT NULL DEFAULT 127,
  `time_departure` TIME NULL,
  PRIMARY KEY (`id_frequency`)
);

CREATE TABLE `airport`.`airport_flight` (
  `id_airport_flight` INT NOT NULL AUTO_INCREMENT,
  `airport` CHAR(3) NOT NULL,
  `flight` INT NOT NULL,
  PRIMARY KEY (`id_airport_flight`)
);

CREATE TABLE `airport`.`flying` (
  `date` DATE NOT NULL,
  `class1` TINYINT UNSIGNED NULL,
  `class2` TINYINT UNSIGNED NULL,
  `class3` TINYINT UNSIGNED NULL,
  `airport_flight` INT NOT NULL
);
