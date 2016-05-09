ALTER TABLE `airport`.`flight`
  ADD INDEX `frequency_idx` (`frequency` ASC);
ALTER TABLE `airport`.`flight`
  ADD CONSTRAINT `frequency`  FOREIGN KEY (`frequency`)
    REFERENCES `airport`.`frequency` (`id_frequency`)
    ON DELETE NO ACTION  ON UPDATE NO ACTION;

ALTER TABLE `airport`.`airport_flight`
  ADD INDEX `flight_idx` (`flight` ASC);
ALTER TABLE `airport`.`airport_flight`
  ADD CONSTRAINT `flight`  FOREIGN KEY (`flight`)
    REFERENCES `airport`.`flight` (`id_flight`)
    ON DELETE CASCADE  ON UPDATE NO ACTION;

ALTER TABLE `airport`.`flying`
  ADD INDEX `airport_flight_idx` (`airport_flight` ASC);
ALTER TABLE `airport`.`flying`
  ADD CONSTRAINT `airport_flight`  FOREIGN KEY (`airport_flight`)
    REFERENCES `airport`.`airport_flight` (`id_airport_flight`)
    ON DELETE CASCADE  ON UPDATE NO ACTION;
