USE `airport`;
DROP procedure IF EXISTS `free_seats`;
DELIMITER $$
USE `airport`$$
CREATE PROCEDURE `free_seats`
  (base char(3), co char(2), num smallint unsigned, d date, count tinyint unsigned)
BEGIN
  if (base is null) then
    if (d is not null) then
      SELECT airport, class1, class2, class3 FROM flying, airport_flight, flight
        WHERE flight=id_flight and airport_flight=id_airport_flight
          and if(co, company=co, true) and if(num, number=num, true) and date=d
          and (class3>=count or class2>=count or class1>=count);
	else
      SELECT airport, class1, class2, class3, date FROM flying, airport_flight, flight
        WHERE flight=id_flight and airport_flight=id_airport_flight
          and if(co, company=co, true) and if(num, number=num, true)
          and (class3>=count or class2>=count or class1>=count);
    end if;
  else
    DROP TABLE if exists t;   # if last run failed
    CREATE TEMPORARY TABLE t
      SELECT airport, class1, class2, class3, date FROM flying, airport_flight, flight
        WHERE flight=id_flight and airport_flight=id_airport_flight
          and if(co, company=co, true) and if(num, number=num, true) and if(d, date=d, true)
          and (class3>=count or class2>=count or class1>=count);
    if (d is not null) then
      set @c1 = -1;
      SELECT class1, class2, class3 into @c1, @c2, @c3 FROM t where airport=base;
      if (@c1 != -1)
        then SELECT @c1 as 'class1', @c2 as 'class2', @c3 as 'class3';
        else SELECT airport, class1, class2, class3 from t;  end if;
	else
      DROP TABLE if exists ft;   # if last run failed
      CREATE TEMPORARY TABLE ft
        SELECT * from t where airport=base;
	  SELECT count(*) into @ft_count from ft;
	  if (@ft_count != 0)
        then SELECT class1, class2, class3, date from ft;
        else SELECT * from t;  end if;
      DROP TABLE ft;
    end if;
    DROP TABLE t;
  end if;
END $$
DELIMITER;
