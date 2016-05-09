CREATE DATABASE  IF NOT EXISTS `airport` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `airport`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: airport
-- ------------------------------------------------------
-- Server version	5.7.7-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airport_flight`
--

DROP TABLE IF EXISTS `airport_flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport_flight` (
  `id_airport_flight` int(11) NOT NULL AUTO_INCREMENT,
  `airport` char(3) NOT NULL,
  `flight` int(11) NOT NULL,
  PRIMARY KEY (`id_airport_flight`),
  KEY `flight_idx` (`flight`),
  CONSTRAINT `flight` FOREIGN KEY (`flight`) REFERENCES `flight` (`id_flight`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport_flight`
--

LOCK TABLES `airport_flight` WRITE;
/*!40000 ALTER TABLE `airport_flight` DISABLE KEYS */;
INSERT INTO `airport_flight` VALUES (1,'DNK',2),(2,'ODS',2),(3,'KBP',1),(4,'ZHL',1);
/*!40000 ALTER TABLE `airport_flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `id_flight` int(11) NOT NULL AUTO_INCREMENT,
  `company` char(2) NOT NULL,
  `number` smallint(4) unsigned NOT NULL,
  `destination` char(3) NOT NULL,
  `frequency` int(11) NOT NULL,
  PRIMARY KEY (`id_flight`),
  KEY `frequency_idx` (`frequency`),
  CONSTRAINT `frequency` FOREIGN KEY (`frequency`) REFERENCES `frequency` (`id_frequency`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'BA',125,'LHR',2),(2,'PS',666,'KBP',1);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flying`
--

DROP TABLE IF EXISTS `flying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flying` (
  `date` date NOT NULL,
  `class1` tinyint(4) DEFAULT NULL,
  `class2` tinyint(4) DEFAULT NULL,
  `class3` tinyint(4) DEFAULT NULL,
  `airport_flight` int(11) NOT NULL,
  KEY `airport_flight_idx` (`airport_flight`),
  CONSTRAINT `airport_flight` FOREIGN KEY (`airport_flight`) REFERENCES `airport_flight` (`id_airport_flight`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flying`
--

LOCK TABLES `flying` WRITE;
/*!40000 ALTER TABLE `flying` DISABLE KEYS */;
INSERT INTO `flying` VALUES ('2015-05-22',10,3,1,1),('2015-05-25',13,12,10,1),('2015-05-22',7,1,0,2),('2015-05-25',14,18,17,2),('2015-05-21',0,0,0,3),('2015-05-22',15,17,3,3),('2015-05-23',13,10,18,3),('2015-05-21',3,1,0,4),('2015-05-22',7,9,14,4),('2015-05-23',14,18,18,4);
/*!40000 ALTER TABLE `flying` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frequency`
--

DROP TABLE IF EXISTS `frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frequency` (
  `id_frequency` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `days` tinyint(4) DEFAULT '127',
  `time_departure` time DEFAULT NULL,
  PRIMARY KEY (`id_frequency`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frequency`
--

LOCK TABLES `frequency` WRITE;
/*!40000 ALTER TABLE `frequency` DISABLE KEYS */;
INSERT INTO `frequency` VALUES (1,'2015-02-01','2015-05-30',21,'13:00:00'),(2,'2012-01-01','2017-12-31',127,'07:00:00');
/*!40000 ALTER TABLE `frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'airport'
--
/*!50003 DROP PROCEDURE IF EXISTS `free_seats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `free_seats`(base char(3), co char(2), num smallint, d date, count tinyint)
BEGIN   # "count" must be > 0
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
