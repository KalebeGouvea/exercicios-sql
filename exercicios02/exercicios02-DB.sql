CREATE DATABASE  IF NOT EXISTS `Universidade` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `Universidade`;
-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: Universidade
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
-- Table structure for table `Alunos`
--

DROP TABLE IF EXISTS `Alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alunos` (
  `MAT` int(10) unsigned NOT NULL,
  `nome` varchar(60) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  PRIMARY KEY (`MAT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alunos`
--

LOCK TABLES `Alunos` WRITE;
/*!40000 ALTER TABLE `Alunos` DISABLE KEYS */;
INSERT INTO `Alunos` VALUES (2015010101,'JOSE DE ALENCAR','RUA DAS ALMAS','NATAL'),(2015010102,'JOÃO JOSÉ','AVENIDA RUY CARNEIRO','JOÃO PESSOA'),(2015010103,'MARIA JOAQUINA','RUA CARROSSEL','RECIFE'),(2015010104,'MARIA DAS DORES','RUA DAS LADEIRAS','FORTALEZA'),(2015010105,'JOSUÉ CLAUDINO DOS SANTOS','CENTRO','NATAL'),(2015010106,'JOSUÉLISSON CLAUDINO DOS SANTOS','CENTRO','NATAL');
/*!40000 ALTER TABLE `Alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Disciplinas`
--

DROP TABLE IF EXISTS `Disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Disciplinas` (
  `COD_DISC` varchar(3) NOT NULL,
  `nome_disc` varchar(60) NOT NULL,
  `carga_hor` int(5) unsigned NOT NULL,
  PRIMARY KEY (`COD_DISC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Disciplinas`
--

LOCK TABLES `Disciplinas` WRITE;
/*!40000 ALTER TABLE `Disciplinas` DISABLE KEYS */;
INSERT INTO `Disciplinas` VALUES ('BD','BANCO DE DADOS',100),('ENG','ENGENHARIA DE SOFTWARE',80),('POO','PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS',100),('WEB','AUTORIA WEB',50);
/*!40000 ALTER TABLE `Disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Historico`
--

DROP TABLE IF EXISTS `Historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Historico` (
  `MAT` int(10) unsigned NOT NULL,
  `COD_DISC` varchar(3) NOT NULL,
  `COD_TURMA` int(2) unsigned NOT NULL,
  `COD_PROF` int(6) unsigned NOT NULL,
  `ANO` smallint(4) unsigned NOT NULL,
  `frequencia` decimal(5,2) unsigned NOT NULL,
  `nota` decimal(4,2) unsigned NOT NULL,
  PRIMARY KEY (`MAT`,`COD_DISC`,`COD_TURMA`,`COD_PROF`,`ANO`),
  KEY `COD_DISC` (`COD_DISC`,`COD_TURMA`,`COD_PROF`,`ANO`),
  CONSTRAINT `Historico_ibfk_1` FOREIGN KEY (`MAT`) REFERENCES `Alunos` (`MAT`),
  CONSTRAINT `Historico_ibfk_2` FOREIGN KEY (`COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`) REFERENCES `Turma` (`COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Historico`
--

LOCK TABLES `Historico` WRITE;
/*!40000 ALTER TABLE `Historico` DISABLE KEYS */;
INSERT INTO `Historico` VALUES (2015010101,'BD',1,212131,2015,78.90,7.20),(2015010101,'ENG',1,122135,2015,96.00,9.25),(2015010101,'POO',1,192011,2015,64.40,6.25),(2015010101,'WEB',1,192011,2015,100.00,10.00),(2015010102,'BD',2,212131,2015,80.00,8.50),(2015010102,'ENG',1,122135,2015,98.00,9.50),(2015010102,'POO',1,192011,2015,70.00,9.00),(2015010102,'WEB',1,192011,2015,75.00,3.40),(2015010103,'BD',1,212131,2015,82.00,7.75),(2015010103,'ENG',1,122135,2015,62.00,2.50),(2015010103,'POO',1,192011,2015,75.00,9.00),(2015010103,'WEB',1,192011,2015,78.00,9.00),(2015010104,'BD',2,212131,2015,81.00,2.50),(2015010104,'ENG',1,122135,2015,64.50,5.50),(2015010104,'POO',1,192011,2015,80.00,4.00),(2015010104,'WEB',1,192011,2015,92.00,8.00),(2015010105,'BD',1,212131,2015,88.00,7.80),(2015010105,'ENG',1,122135,2015,72.40,5.80),(2015010105,'POO',1,192011,2015,100.00,4.50),(2015010105,'WEB',1,192011,2015,95.50,8.00),(2015010106,'BD',2,212131,2015,78.70,4.50),(2015010106,'ENG',1,122135,2015,76.50,6.80),(2015010106,'POO',1,192011,2015,95.00,8.50),(2015010106,'WEB',1,192011,2015,91.80,7.50);
/*!40000 ALTER TABLE `Historico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professores`
--

DROP TABLE IF EXISTS `Professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Professores` (
  `COD_PROF` int(6) unsigned NOT NULL,
  `nome` varchar(60) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  PRIMARY KEY (`COD_PROF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professores`
--

LOCK TABLES `Professores` WRITE;
/*!40000 ALTER TABLE `Professores` DISABLE KEYS */;
INSERT INTO `Professores` VALUES (122135,'ADORILSON BEZERRA','AVENIDA SALGADO FILHO','NATAL'),(192011,'DIEGO OLIVEIRA','AVENIDA ROBERTO FREIRE','NATAL'),(212131,'NICKERSON FERREIRA','RUA MANAÍRA','JOÃO PESSOA');
/*!40000 ALTER TABLE `Professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Turma`
--

DROP TABLE IF EXISTS `Turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Turma` (
  `COD_DISC` varchar(3) NOT NULL,
  `COD_TURMA` int(2) unsigned NOT NULL,
  `COD_PROF` int(6) unsigned NOT NULL,
  `ANO` smallint(4) unsigned NOT NULL,
  `horario` varchar(13) NOT NULL,
  PRIMARY KEY (`COD_DISC`,`COD_TURMA`,`COD_PROF`,`ANO`),
  KEY `COD_PROF` (`COD_PROF`),
  CONSTRAINT `Turma_ibfk_1` FOREIGN KEY (`COD_DISC`) REFERENCES `Disciplinas` (`COD_DISC`),
  CONSTRAINT `Turma_ibfk_2` FOREIGN KEY (`COD_PROF`) REFERENCES `Professores` (`COD_PROF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Turma`
--

LOCK TABLES `Turma` WRITE;
/*!40000 ALTER TABLE `Turma` DISABLE KEYS */;
INSERT INTO `Turma` VALUES ('BD',1,212131,2015,'11H-12H'),('BD',2,212131,2015,'13H-14H'),('ENG',1,122135,2015,'10H-11H'),('POO',1,192011,2015,'08H-09H'),('WEB',1,192011,2015,'07H-08H');
/*!40000 ALTER TABLE `Turma` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-20 18:42:48
