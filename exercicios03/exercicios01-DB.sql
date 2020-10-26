CREATE DATABASE  IF NOT EXISTS `exercicio03` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `exercicio03`;
-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: exercicio03
-- ------------------------------------------------------
-- Server version	10.4.13-MariaDB

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
-- Table structure for table `assinante`
--

DROP TABLE IF EXISTS `assinante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assinante` (
  `cd_assinante` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cd_ramo` int(11) DEFAULT NULL,
  `cd_tipo` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_assinante`),
  KEY `FK_assinante1` (`cd_ramo`),
  KEY `FK_assinante2` (`cd_tipo`),
  CONSTRAINT `FK_assinante1` FOREIGN KEY (`cd_ramo`) REFERENCES `ramo` (`cd_ramo`),
  CONSTRAINT `FK_assinante2` FOREIGN KEY (`cd_tipo`) REFERENCES `tipo` (`cd_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assinante`
--

LOCK TABLES `assinante` WRITE;
/*!40000 ALTER TABLE `assinante` DISABLE KEYS */;
INSERT INTO `assinante` VALUES (1,'JOÃO',1,2),(2,'JOSÉ',2,1),(3,'MARIA',2,1),(4,'MARIA BETÂNIA',3,3),(5,'JOANA',1,1);
/*!40000 ALTER TABLE `assinante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `cd_endereco` int(11) NOT NULL,
  `ds_endereco` varchar(50) DEFAULT NULL,
  `complemento` varchar(50) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `CEP` varchar(50) DEFAULT NULL,
  `cd_assinante` int(11) DEFAULT NULL,
  `cd_municipio` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_endereco`),
  KEY `FK_end` (`cd_assinante`),
  KEY `FK_end2` (`cd_municipio`),
  CONSTRAINT `FK_end` FOREIGN KEY (`cd_assinante`) REFERENCES `assinante` (`cd_assinante`),
  CONSTRAINT `FK_end2` FOREIGN KEY (`cd_municipio`) REFERENCES `municipio` (`cd_municipio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'RUA ABC','APTO 201','TESTE','999999-00',1,1),(2,'RUA TESTES ABC','','TESTE','999999-00',1,1),(3,'RUA bbbbVVVVV','APTO 1201','CENTRO','999999-00',2,4),(4,'RUA VV','APTO 1201','CENTRO','999999-00',3,5),(5,'RUA testeVVVVV','APTO 1201','CENTRO','999999-00',4,2),(6,'RUA AtesteVVVVVVV','APTO 1201','CENTRO','999999-00',5,3);
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipio` (
  `cd_municipio` int(11) NOT NULL,
  `ds_municipio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cd_municipio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */;
INSERT INTO `municipio` VALUES (1,'JOÃO CÂMARA'),(2,'CEARA MIRIM'),(3,'TOUROS'),(4,'SÃO MIGUEL'),(5,'PELOTAS');
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramo`
--

DROP TABLE IF EXISTS `ramo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ramo` (
  `cd_ramo` int(11) NOT NULL,
  `ds_ramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cd_ramo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramo`
--

LOCK TABLES `ramo` WRITE;
/*!40000 ALTER TABLE `ramo` DISABLE KEYS */;
INSERT INTO `ramo` VALUES (1,'INFORMÁTICA'),(2,'MEDICINA'),(3,'COMÉRCIO');
/*!40000 ALTER TABLE `ramo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `cd_fone` int(11) NOT NULL,
  `ddd` varchar(3) DEFAULT NULL,
  `n_fone` varchar(10) DEFAULT NULL,
  `cd_endereco` int(11) DEFAULT NULL,
  PRIMARY KEY (`cd_fone`),
  KEY `FK_fone` (`cd_endereco`),
  CONSTRAINT `FK_fone` FOREIGN KEY (`cd_endereco`) REFERENCES `endereco` (`cd_endereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
INSERT INTO `telefone` VALUES (1,'84','9999999999',1),(2,'84','9999999999',5),(3,'84','9999999999',6),(4,'84','9999999999',2);
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo` (
  `cd_tipo` int(11) NOT NULL,
  `ds_tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cd_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'PREMIUM'),(2,'BÁSICO'),(3,'GRÁTIS'),(4,'RESIDENCIAL');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-26 19:20:38
