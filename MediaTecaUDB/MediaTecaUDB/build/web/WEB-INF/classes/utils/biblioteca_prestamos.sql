-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
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
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_ejemplar` varchar(50) DEFAULT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_ejemplar` (`id_ejemplar`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`id_ejemplar`) REFERENCES `ejemplares` (`id`),
  CONSTRAINT `prestamos_chk_1` CHECK (((`fecha_prestamo` <= `fecha_devolucion`) or (`fecha_devolucion` is null)))
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,2,'LIB001','2023-07-23','2023-07-23',NULL),(2,2,'LIB001','2023-12-07','2023-12-07',NULL),(3,2,'LIB002','2023-12-07','2023-12-07',NULL),(4,2,'LIB003','2023-12-07','2023-12-07',NULL),(5,2,'LIB002','2023-12-07','2023-12-07',NULL),(6,2,'LIB003','2023-12-07','2023-12-07',NULL),(7,2,'LIB003','2023-12-07','2023-12-07',NULL),(8,2,'LIB001','2023-12-07','2023-12-07',NULL),(9,2,'LIB002','2023-12-07','2023-12-07',NULL),(10,2,'LIB001','2023-12-07','2023-12-07',NULL),(11,2,'LIB002','2023-12-07','2023-12-07',NULL),(12,2,'LIB001','2023-12-07','2023-12-07',NULL),(13,2,'LIB003','2023-12-07','2023-12-07',NULL),(14,2,'LIB001','2023-12-07','2023-12-07',NULL),(15,2,'LIB002','2023-12-07','2023-12-07',NULL),(16,2,'LIB001','2023-12-07','2023-12-07',NULL),(17,2,'LIB002','2023-12-07','2023-12-07',NULL),(18,2,'LIB002','2023-12-08','2023-12-08',NULL),(19,2,'LIB002','2023-12-08','2023-12-08',NULL),(20,2,'LIB003','2023-12-08','2023-12-28',NULL),(21,4,'LIB001','2023-12-08',NULL,NULL),(22,4,'LIB003','2023-12-08','2023-12-08',NULL),(23,2,'LIB002','2023-12-08','2023-12-08',NULL),(24,2,'LIB002','2023-12-08','2023-12-08',NULL),(25,2,'LIB002','2023-12-08','2023-12-28',NULL),(26,2,'LIB002','2023-12-08','2023-12-08',NULL),(27,2,'LIB002','2023-12-08','2023-12-08',NULL),(28,2,'LIB003','2023-12-08','2023-12-28',NULL),(29,2,'LIB001','2023-12-08','2023-12-08',NULL),(30,2,'LIB003','2023-12-08','2023-12-28',NULL),(31,2,'LIB001','2023-12-08','2023-12-08',NULL),(32,2,'LIB002','2023-12-08','2023-12-28',NULL),(33,2,'LIB003','2023-12-08',NULL,NULL),(34,1,'LIB001','2024-06-07',NULL,'cancelado'),(35,1,'LIB001','2024-06-07',NULL,'cancelado'),(36,1,'LIB001','2024-06-07',NULL,'cancelado'),(37,1,'LIB001','2024-06-07','2024-06-07','cancelado'),(38,1,'LIB001','2024-06-07',NULL,'vigente'),(39,1,'LIB001','2024-06-07',NULL,'vigente'),(40,1,'LIB001','2024-06-07',NULL,'vigente'),(41,1,'LIB001','2024-06-07',NULL,'vigente'),(42,1,'LIB003','2024-06-07',NULL,'vigente'),(43,1,'LIB003','2024-06-07','2024-06-07','cancelado');
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `incrementar_prestados` AFTER INSERT ON `prestamos` FOR EACH ROW BEGIN
    UPDATE ejemplares
    SET prestados = prestados + 1
    WHERE id = NEW.id_ejemplar;
END */;;
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

-- Dump completed on 2024-06-07 18:27:01
