-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: my_db
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trips` (
  `trip_id` int NOT NULL AUTO_INCREMENT,
  `start_location` varchar(400) DEFAULT NULL,
  `end_location` varchar(400) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `vehicle_id` int DEFAULT NULL,
  `outbound_time` varchar(45) DEFAULT NULL,
  `return_time` varchar(45) DEFAULT NULL,
  `start_latitude` varchar(300) DEFAULT NULL,
  `start_longtude` varchar(300) DEFAULT NULL,
  `destination_latitude` varchar(300) DEFAULT NULL,
  `destination_longtude` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`trip_id`),
  KEY `driver_id_idx` (`driver_id`),
  KEY `vehicle_id_idx` (`vehicle_id`),
  CONSTRAINT `driver_id2` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`),
  CONSTRAINT `vehicle_d2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (2,'Sandton','Rosebank','08:00',1,1,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Malboro','Revonia','08:00',2,2,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Sandton','Rosebank','08:00',3,3,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Sandton','Rosebank','08:00',4,4,NULL,NULL,NULL,NULL,NULL,NULL),(8,'123 Main St, Cityville','456 Elm St, Townsville','08:00',1,1,'2024-07-16T08:00:00Z','2024-07-16T17:00:00Z','34.052235','-118.243683','36.169941','-115.139832'),(9,'University of Johannesburg Sophiatown Residence Richmond Avenue Rossmore','Cowfish Rand Steam Napier Road Richmond','08:00',1,1,'3:20 PM','1:20 PM','-26.1833315','28.0033847','-26.18268450157116','28.016327967429383'),(10,'null Lothbury Road Rossmore','null Clieveden Avenue Richmond','08:00',1,1,'12:46 PM','4:20 PM','-26.182601373325767','28.005719495119457','-26.182385707405935','28.009015393687932'),(11,'University of Johannesburg Sophiatown Residence Richmond Avenue Rossmore','University of Johannesburg Sophiatown Residence Richmond Avenue Rossmore','08:00',1,1,'5:14 PM','5:14 PM','-26.1833199','28.0033753','-26.1833199','28.0033753');
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-18  7:00:14
