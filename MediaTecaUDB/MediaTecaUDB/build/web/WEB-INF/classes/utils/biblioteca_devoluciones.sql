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
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devoluciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_prestamo` int DEFAULT NULL,
  `fecha_devolucion` date NOT NULL,
  `estado_devolucion` enum('En tiempo','Atrasado') NOT NULL,
  `comentarios` varchar(255) DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_prestamo` (`id_prestamo`),
  KEY `fk_devoluciones_usuarios` (`id_usuario`),
  CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id`),
  CONSTRAINT `fk_devoluciones_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
INSERT INTO `devoluciones` VALUES (1,2,'2023-12-07','En tiempo','Es todo correcto',NULL),(2,1,'2023-07-23','En tiempo','Todo bien',NULL),(8,6,'2023-12-07','En tiempo','Bien',2),(9,4,'2023-12-07','Atrasado','Atrasado muy mal',2),(10,5,'2023-12-07','Atrasado','Don quijote',2),(11,3,'2023-12-07','Atrasado','Todo bien',2),(12,7,'2023-12-07','Atrasado','Todo mal',2),(13,9,'2023-12-07','Atrasado','Malo',2),(14,8,'2023-12-07','Atrasado','ATRAS',2),(15,10,'2023-12-07','Atrasado','todo mal',2),(16,11,'2023-12-07','Atrasado','WDA',2),(17,12,'2023-12-07','Atrasado','aaaaaaaaaaaaaaaaaaaaaa',2),(18,13,'2023-12-07','Atrasado','BASTA',2),(19,14,'2023-12-07','Atrasado','goood',2),(20,15,'2023-12-07','En tiempo','Todo bien',2),(21,16,'2023-12-07','Atrasado','DWAD',2),(22,17,'2023-12-07','Atrasado','En mal estado',2),(23,18,'2023-12-08','En tiempo','Todo bien',2),(24,19,'2023-12-08','En tiempo','A tiempo',2),(25,22,'2023-12-08','En tiempo','En tiempo, en buen estado',4),(26,20,'2023-12-28','Atrasado','Nada',2),(27,23,'2023-12-08','Atrasado','sa',2),(28,24,'2023-12-08','Atrasado','Hola',2),(29,25,'2023-12-28','Atrasado','Nada',2),(30,26,'2023-12-08','Atrasado','asd',2),(32,27,'2023-12-08','Atrasado','fds',2),(33,28,'2023-12-28','Atrasado','Nada',2),(34,29,'2023-12-08','Atrasado','adwd',2),(35,30,'2023-12-28','Atrasado','Nada',2),(36,31,'2023-12-08','Atrasado','Atrasado, con manchas',2),(37,32,'2023-12-28','Atrasado','Nada',2);
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_prestados` AFTER INSERT ON `devoluciones` FOR EACH ROW BEGIN
    UPDATE prestamos
    SET fecha_devolucion = NEW.fecha_devolucion
    WHERE id = NEW.id_prestamo;

    UPDATE ejemplares
    SET prestados = prestados - 1
    WHERE id = (SELECT id_ejemplar FROM prestamos WHERE id = NEW.id_prestamo);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_monto_pagos` AFTER INSERT ON `devoluciones` FOR EACH ROW BEGIN
    DECLARE dias_excedidos INT;
    DECLARE monto_actual DECIMAL(10, 2);
    
    -- Calcular la diferencia en días entre la fecha de devolución y la fecha de préstamo
    SET dias_excedidos = DATEDIFF(NEW.fecha_devolucion, (SELECT fecha_prestamo FROM prestamos WHERE id = NEW.id_prestamo));
    
    -- Si la diferencia es mayor a una semana, actualizar el monto en la tabla de pagos
    IF dias_excedidos > 7 THEN
        -- Obtener el monto actual en la tabla de pagos
        SELECT monto INTO monto_actual FROM pagos WHERE id_prestamo = NEW.id_prestamo;
        
        -- Verificar si ya hay un registro en la tabla de pagos para el mismo préstamo
        IF monto_actual IS NULL THEN
            -- Insertar un nuevo registro en la tabla de pagos con fecha de pago nula
            INSERT INTO pagos (id_usuario, monto, fecha_pago, id_prestamo) 
            VALUES (NEW.id_usuario, (dias_excedidos - 7) * 0.5, NULL, NEW.id_prestamo);
        ELSE
            -- Actualizar el monto y establecer la fecha de pago en nulo
            UPDATE pagos
            SET monto = monto_actual + (dias_excedidos - 7) * 0.5,
                fecha_pago = NULL
            WHERE id_prestamo = NEW.id_prestamo;
        END IF;
    END IF;
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

-- Dump completed on 2024-06-07 18:27:00
