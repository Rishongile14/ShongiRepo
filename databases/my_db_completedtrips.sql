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
-- Table structure for table `completedtrips`
--

DROP TABLE IF EXISTS `completedtrips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `completedtrips` (
  `completedtrips_id` int NOT NULL AUTO_INCREMENT,
  `bookedtrips_id` int DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `status` varchar(150) DEFAULT NULL,
  `passanger_id` int DEFAULT NULL,
  `trip_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `vehicle_id` int DEFAULT NULL,
  PRIMARY KEY (`completedtrips_id`),
  KEY `bookedtrips_id_idx` (`bookedtrips_id`),
  KEY `passenger_id_idx` (`passanger_id`),
  KEY `trip_id5_idx` (`trip_id`),
  KEY `driver_id5_idx` (`driver_id`),
  KEY `vehicle_id5_idx` (`vehicle_id`),
  CONSTRAINT `bookedtrips_id` FOREIGN KEY (`bookedtrips_id`) REFERENCES `bookedtrips` (`bookedtrips_id`),
  CONSTRAINT `driver_id5` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`),
  CONSTRAINT `passenger_id5` FOREIGN KEY (`passanger_id`) REFERENCES `users` (`id`),
  CONSTRAINT `trip_id5` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`trip_id`),
  CONSTRAINT `vehicle_id5` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completedtrips`
--

LOCK TABLES `completedtrips` WRITE;
/*!40000 ALTER TABLE `completedtrips` DISABLE KEYS */;
INSERT INTO `completedtrips` VALUES (25,38,'2024-07-12 16:50:43','CANCELLED',29,2,1,1),(26,39,'2024-07-12 16:50:43','CANCELLED',29,3,2,2),(27,40,'2024-07-12 16:54:41','CANCELLED',32,3,2,2);
/*!40000 ALTER TABLE `completedtrips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-13 13:28:34
