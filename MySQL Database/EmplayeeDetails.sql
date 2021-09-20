-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: webappdemo
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(45) NOT NULL,
  `city_is_deleted` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Chennai','1'),(2,'Bangalore','1'),(3,'Mumbai','0'),(4,'Hyderabad','0'),(7,'Kolkata','0'),(9,'Pune','0');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datetime`
--

DROP TABLE IF EXISTS `datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datetime` (
  `dt_id` int NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`dt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datetime`
--

LOCK TABLES `datetime` WRITE;
/*!40000 ALTER TABLE `datetime` DISABLE KEYS */;
INSERT INTO `datetime` VALUES (1,'2020-10-05 22:11:00'),(2,'2020-10-05 20:11:00'),(3,'2020-11-05 20:11:00'),(4,'2020-11-05 00:00:00'),(5,'2020-11-05 05:00:00'),(6,'2020-11-30 00:00:00'),(7,'2020-11-30 00:00:00');
/*!40000 ALTER TABLE `datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(45) NOT NULL,
  `dept_is_deleted` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Science','0'),(2,'Social','0'),(3,'Astrology','0'),(4,'Aerodynamics','0'),(5,'Physics','0'),(6,'Chemistry','0'),(7,'Hydrodynamics','0'),(8,'Clinical','0'),(9,'Observation','0'),(10,'Art','0'),(11,'Production','0'),(12,'Marketing','0'),(13,'Accounting','0'),(14,'Human Resources','0'),(15,'Finance','0');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empdept`
--

DROP TABLE IF EXISTS `empdept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empdept` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emp_id` int NOT NULL,
  `dept_id` int NOT NULL,
  `empdept_is_deleted` varchar(45) NOT NULL,
  `empdept_created_time` datetime DEFAULT NULL,
  `empdept_deleted_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pk1_idx` (`emp_id`),
  KEY `pk2_idx` (`dept_id`),
  CONSTRAINT `pk1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  CONSTRAINT `pk2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empdept`
--

LOCK TABLES `empdept` WRITE;
/*!40000 ALTER TABLE `empdept` DISABLE KEYS */;
INSERT INTO `empdept` VALUES (1,1,1,'0',NULL,NULL),(2,2,2,'0',NULL,NULL),(3,3,3,'0',NULL,NULL),(4,4,1,'0',NULL,NULL),(5,5,1,'0',NULL,NULL),(6,6,1,'0',NULL,NULL),(7,8,3,'0',NULL,NULL),(8,9,2,'0',NULL,NULL),(9,10,3,'1',NULL,'2021-09-17 18:39:00'),(10,11,2,'0',NULL,NULL),(11,12,1,'0',NULL,NULL),(12,13,2,'0',NULL,NULL),(13,14,2,'0',NULL,NULL),(14,15,4,'0',NULL,NULL),(15,16,7,'0',NULL,NULL),(16,17,3,'0',NULL,NULL),(17,18,5,'0',NULL,NULL),(18,19,2,'0',NULL,NULL),(19,21,12,'0',NULL,NULL),(20,22,3,'0',NULL,NULL),(21,23,4,'1',NULL,'2021-09-15 14:37:00'),(22,24,2,'1',NULL,NULL),(23,24,14,'0',NULL,NULL),(24,24,5,'1',NULL,NULL),(25,1,2,'1',NULL,NULL),(26,1,3,'1',NULL,NULL),(27,7,5,'0',NULL,NULL),(28,24,4,'1',NULL,NULL),(29,24,2,'0',NULL,NULL),(30,1,4,'1',NULL,NULL),(31,10,6,'0',NULL,NULL),(32,16,6,'1',NULL,'2021-08-13 14:59:00'),(34,10,4,'1','2021-09-15 12:46:00','2021-09-17 18:39:00'),(35,23,3,'0','2021-09-15 14:36:00',NULL),(36,23,5,'1','2021-09-15 14:36:00','2021-09-17 18:43:00'),(37,10,5,'0','2021-09-17 18:39:00',NULL),(38,23,4,'0','2021-09-17 18:43:00',NULL);
/*!40000 ALTER TABLE `empdept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `subject` varchar(45) NOT NULL,
  `is_active` varchar(1) NOT NULL,
  `city_id` int NOT NULL,
  `emp_joining_time` datetime DEFAULT NULL,
  `emp_deleted_time` datetime DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `f2_idx` (`city_id`),
  CONSTRAINT `fk2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Ted','1234567890','Geography','n',1,'2021-08-09 15:02:18',NULL),(2,'Jake','1234567890','Data Science','y',2,'2021-05-27 23:40:00',NULL),(3,'Lily','1234567890','Machine Learning','y',3,'2021-06-02 04:40:00',NULL),(4,'Amy','1234567890','Programming Language','y',2,'2021-08-13 12:12:00',NULL),(5,'Robin','2345678901','Engineering Graphics','y',1,'2021-08-06 21:00:00',NULL),(6,'Charles','3456789012','Engineering Physics','y',1,'2021-08-02 03:15:00',NULL),(7,'Barney','4567890123','Engineering Chemistry','y',2,'2021-07-14 08:25:00',NULL),(8,'Marshall','5678901234','Data Structures','y',3,'2021-02-28 21:00:00',NULL),(9,'Terry','6789012345','Digital System Design','y',2,'2021-03-01 07:35:00',NULL),(10,'Rosa','7890123456','Technical English','y',3,'2021-06-17 10:30:00',NULL),(11,'Gina','8901234567','Machine Learning','y',2,'2021-05-17 11:15:00',NULL),(12,'Holt','1234567890','Engineering Chemistry','y',1,'2021-07-24 10:05:00',NULL),(13,'Judy','1234567890','Digital System Design','y',4,'2020-03-18 01:15:00',NULL),(14,'Hitchcock','1234567890','Geography','y',2,'2021-01-18 04:15:00',NULL),(15,'Scully','1234567890','Programming Language','y',4,'2021-06-15 01:10:00',NULL),(16,'Sheldon','1234567891','Data Science','y',7,'2021-06-10 08:00:00',NULL),(17,'Leonard','3624893784','Engineering Graphics','y',7,'2020-06-09 03:10:00',NULL),(18,'Penny','8485784250','Digital System Design','y',3,'2021-02-18 01:45:00',NULL),(19,'Raj','2353508753','Geography','y',3,'2020-07-05 04:50:00',NULL),(21,'Howard','9876543219','Engineering Physics','y',2,'2020-02-29 10:30:00',NULL),(22,'Bernadette','1234506789','Machine Learning','y',2,'2021-08-06 00:00:00',NULL),(23,'Ami','1234567890','Data Science','y',2,'2020-12-31 23:55:00',NULL),(24,'Stuart','1234567890','Machine Learning','y',7,'2020-11-26 18:30:00',NULL);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phonenumber` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-20 11:07:23
