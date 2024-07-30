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
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `idVehicle` int NOT NULL AUTO_INCREMENT,
  `Reg_Number` varchar(255) DEFAULT NULL,
  `Manufacturer` varchar(255) DEFAULT NULL,
  `Model` varchar(1000) DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Pic1` varchar(2000) DEFAULT NULL,
  `Pic2` varchar(2000) DEFAULT NULL,
  `Pic3` varchar(2000) DEFAULT NULL,
  `Pic4` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`idVehicle`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'ABC123','Toyota','Corolla',NULL,'https://example.com/car1.jpg','https://example.com/car2.jpg','https://example.com/car3.jpg','https://example.com/car4.jpg'),(2,'John',NULL,'1234567890',2019,'p1.jpg','p2.jpg','p3.jpg','p4.jpg'),(3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'John',NULL,'1234567890',2019,'p1.jpg','p2.jpg','p3.jpg','p4.jpg'),(6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'PM 01 GP','TOYOTA','YARIS',2019,'Gold And Black Modern Elegant Prom Night Celebration Poster.png','406216786.jpg','406216735.jpg','406216637.jpg'),(8,'DY 09 GP','TOYOTA','YARIS',2022,'406216637.jpg','406216637.jpg','406216637.jpg','406216786.jpg'),(9,'GR 09 GP','TOYOTA','YARIS',2024,'406216637.jpg','406216786.jpg','406216637.jpg','406216735.jpg'),(10,'ZY 09 GP','TOYOTA','TOP',2025,'Gold And Black Modern Elegant Prom Night Celebration Poster.png','406216637.jpg','406216637.jpg','406216786.jpg'),(11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'Test','Test','toyota',2016,'assets/images/dockets1-news-1670510159113735.jpeg','assets/images/809de400f24f5417b7e23a2e6cccfb13.jpg','assets/images/809de400f24f5417b7e23a2e6cccfb13.jpg','assets/images/dockets1-news-1670510159113735.jpeg');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-13 13:28:33
