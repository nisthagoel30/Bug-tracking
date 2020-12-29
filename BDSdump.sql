-- MySQL dump 10.13  Distrib 5.1.30, for Win32 (ia32)
--
-- Host: localhost    Database: BDS
-- ------------------------------------------------------
-- Server version	5.1.30-community

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
-- Table structure for table `assignproject`
--

DROP TABLE IF EXISTS `assignproject`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `assignproject` (
  `projectId` varchar(6) DEFAULT NULL,
  `empCode` int(4) DEFAULT NULL,
  KEY `projectId` (`projectId`),
  KEY `empCode` (`empCode`),
  CONSTRAINT `assignproject_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `assignproject_ibfk_2` FOREIGN KEY (`empCode`) REFERENCES `employee` (`empCode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `assignproject`
--

LOCK TABLES `assignproject` WRITE;
/*!40000 ALTER TABLE `assignproject` DISABLE KEYS */;
INSERT INTO `assignproject` VALUES ('P101',1111),('P102',1112),('P103',1113),('P104',1114),('P105',1115),('P106',1116),('P107',1117),('P108',1118),('P109',1119),('P110',1120),('P111',1121),('P112',1122);
/*!40000 ALTER TABLE `assignproject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bugreport`
--

DROP TABLE IF EXISTS `bugreport`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bugreport` (
  `bugNo` varchar(4) NOT NULL,
  `bugCode` varchar(4) DEFAULT NULL,
  `projectId` varchar(6) DEFAULT NULL,
  `empCode` int(4) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `bugDesc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bugNo`),
  KEY `bugCode` (`bugCode`),
  KEY `projectId` (`projectId`),
  KEY `empCode` (`empCode`),
  CONSTRAINT `bugreport_ibfk_1` FOREIGN KEY (`bugCode`) REFERENCES `bugtype` (`bugcode`) ON DELETE CASCADE,
  CONSTRAINT `bugreport_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `bugreport_ibfk_3` FOREIGN KEY (`empCode`) REFERENCES `employee` (`empCode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `bugreport`
--

LOCK TABLES `bugreport` WRITE;
/*!40000 ALTER TABLE `bugreport` DISABLE KEYS */;
INSERT INTO `bugreport` VALUES ('BN1','B1','P103',1113,'RESOLVED','there are many fuctional errors'),('BN10','B6','P110',1122,'PENDING','there are many logical errors and many absurd calculation issues'),('BN11','B1','P104',1124,'RESOLVED','there are many fuctional errors.FIX IT!!!'),('BN12','B7','P101',1111,'PENDING','proper error handling is not done causing unexpected termination'),('BN2','B3','P105',1115,'PENDING','comments are missing and there is communication problem'),('BN3','B8','P102',1117,'RESOLVED','there are many calculation issues'),('BN4','B6','P111',1119,'PENDING','many logical errors,not giving expected output'),('BN5','B2','P106',1123,'RESOLVED','there are many compilation errors and no proper comments are given'),('BN6','B1','P102',1116,'PENDING','there are many fuctional errors'),('BN7','B5','P109',1118,'RESOLVED','communication problem with the user'),('BN8','B4','P107',1125,'PENDING','there are many run time errors.FIX IT'),('BN9','B7','P108',1121,'RESOLVED','proper error handling is not done causing unexpected termination');
/*!40000 ALTER TABLE `bugreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bugtype`
--

DROP TABLE IF EXISTS `bugtype`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bugtype` (
  `bugcode` varchar(4) NOT NULL,
  `bugcategory` varchar(15) DEFAULT NULL,
  `bugseverty` varchar(100) NOT NULL,
  PRIMARY KEY (`bugcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `bugtype`
--

LOCK TABLES `bugtype` WRITE;
/*!40000 ALTER TABLE `bugtype` DISABLE KEYS */;
INSERT INTO `bugtype` VALUES ('B1','medium','Functional Errors'),('B2','low','Compilation Errors'),('B3','critical','Missing commands'),('B4','major','Run time Errors'),('B5','major','Communication problems'),('B6','medium','Logical errors'),('B7','low','Inappropriate error handling'),('B8','critical','Calculation issues');
/*!40000 ALTER TABLE `bugtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `employee` (
  `empCode` int(4) NOT NULL,
  `empName` varchar(30) NOT NULL,
  `empEmail` varchar(40) NOT NULL,
  `empPassword` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `DOB` varchar(20) DEFAULT NULL,
  `mobileNo` bigint(20) DEFAULT NULL,
  `Role` varchar(20) NOT NULL,
  PRIMARY KEY (`empCode`),
  UNIQUE KEY `empEmail` (`empEmail`),
  UNIQUE KEY `mobileNo` (`mobileNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1111,'Steven King','sking@gmail.com','2db80b368390e97a9d83140732fa983f','Male','17-06-1993',7894551264,'Tester'),(1112,'Muskan Singhal','msinghal@gmail.com','1f1088be6da3f0cf15c5ba9e8fa45046','Female','01-11-1999',7555555598,'Admin'),(1113,'David Austin','daustin@gmail.com','6253ee260c63c524c2927aaea322e877','Male','11-12-1995',7557849598,'Developer'),(1114,'John Seo','jseo@gmail.com','9d1d423081c51bb7b6f0086422087ea6','Male','14-06-1995',9587461578,'Tester'),(1115,'Nistha Goel','ngoel@gmail.com','e1a3fe8c88e78c71bdbc2790a1281b25','Female','07-07-1996',8459761238,'Admin'),(1116,'Patrick Sully','psully@gmail.com','19cbca94147a2e5c43c97bf6d08dc862','Male','31-01-1994',8259746312,'Tester'),(1117,'Claura Vishney','cvishney@gmail.com','931c18bf773c569f872b5f5088e21215','Female','26-08-1997',4587236915,'Tester'),(1118,'Joshua Patel','jpatel@gmail.com','b43fe972a3c4a8f6807ec62e59f0e49b','Male','18-03-1995',8527419636,'Developer'),(1119,'Daniel Matos','dmatos@gmail.com','b63296ea84c86e3bb028adc8d980751b','Male','24-11-1997',6987542584,'Tester'),(1120,'Taylor Fox','tfox@gmail.com','23956d3c4461c39b59f5b86d5459d6d8','Male','10-10-1993',7845129461,'Manager'),(1121,'Mayank Giri','mgiri@gmail.com','764c211c33d49bce403784b9e33a2537','Male','15-02-1998',6897451283,'Admin'),(1122,'Allen Hall','ahall@gmail.com','7ee4a88433ac0f54d8465612466d4255','Male','12-12-1999',6974581239,'Tester'),(1123,'Jack Gates','jgates@gmail.com','083ddca4bfe9b1b7563f6901083f9b96','Male','17-05-1989',9568723415,'Developer'),(1124,'Kelly Perkins','kperkins@gmail.com','91827afe18956967649c2c632f6d384f','Female','04-08-1995',7698412394,'Admin'),(1125,'Sarah Bell','sbell@gmail.com','b7a4c818109e0ffee4e2ff51d40a1fd0','Female','12-01-1997',6258974139,'Developer');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `project` (
  `projectId` varchar(6) NOT NULL,
  `projectName` varchar(30) NOT NULL,
  `SDate` varchar(30) NOT NULL,
  `EDate` varchar(30) DEFAULT NULL,
  `projectDesc` text,
  PRIMARY KEY (`projectId`),
  UNIQUE KEY `projectName` (`projectName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('P101','EMPLOYEE MANAGEMENT SYSTEM','19-01-2001','27-03-2003','To add,update,delete the profile details of an employee'),('P102','Titan','07-12-2009','23-03-2013','Apple is mum, but Insiders report that the company is working on a car called \"Titan,\" slated to be road-ready in 2019. With a name that gigantic, buzz is already building about the features that may or may not rival Google\'s self-driving cars.'),('P103','Project Hanks','19-10-2014','20-09-2018','Earlier this year, when Verizon Communications was looking to take over AOL, they needed to keep the deal secret and came up with a code name. According to the Telegraph, Project Hanks is the name they chose, which may not make sense until you remember that Tom Hanks starred in the movie You\'ve Got Mail (1998), a romantic comedy about a relationship built on AOL\'s famous mail notification.'),('P104','Kodiak','10-10-2008','20-11-2018','Unlike some other companies that have a codename and then change it to something else when it comes to market, in 2000, Apple developed its first version of Mac OS X with the codename Kodiak. It\'s since followed that theme with updates with other powerful creatures of the wild, such as Puma, Jaguar, Panther, Leopard, Snow Leopard and Lion.'),('P105','Code Talkers','28-11-2018','05-06-2019','This was the project name for the secret WWII program to recruit Cherokee, Creek, Choctow and other tribal members to transmit coded messages in Native American languages. It was also popularized in the Nicholas Cage classic of cinema, Windtalkers.'),('P106','Project Blue Book','27-08-1999','03-06-2003','If you don\'t already know, then you probably don\'t have the clearance. But for the sake of disclosure. Project Blue Book was the code name for the US Air Force investigations into UFO sightings. But you didn\'t hear that from us.'),('P107','X Lab','12-09-1987','30-12-2003','They may have been known earlier for their unofficial slogan \"Don\'t be evil,\" but that doesn\'t mean Google doesn\'t have a secret lair. At the company\'s secret \"X\" Lab, projects like the Self-Driving Car and Google Glass are built under the cloak and veil secrecy deserved of its uber-mysterious name.'),('P108','Project 404','09-06-1999','11-11-2008','The code name for a covert US Air Force mission to Laos during the Vietnam War to supply line crew technicians. Today, it\'s the code name for a webpage that can no longer be found.'),('P109','Manhattan Project','21-09-2007','24-11-2015','The super-secret project to develop an atomic bomb during World War II was a bee hive of activity for some of the smartest minds at the time, but all they could come up with in terms of a name for their work was \"Manhattan\" because they began the research in an simple office building located in Manhattan, New York. They eventually moved to more secure environs out of the area, but the classy name remained.'),('P110','Durango','03-11-2017','19-04-2018','When Microsoft was looking to build upon its wildly popular XBox 360 gaming console, Durango was its name-o. But like all Microsoft projects, the project name was far from the final product name. In this case, they thought long and hard and hired the best people to release the One. XBox One.'),('P111','Apollo','23-01-2007','29-09-2009','One of the most famous projects of the last century, the Apollo program, was designed to land humans on the moon and bring them back home alive. It\'s the kind of story more told in myth, which is maybe why NASA (an acronym for National Aeronautics and Space Administration) went back to the Greeks. Apollo is associated with the Greek verb meaning to destroy. That may sound counterintuitive, but in Greek mythology Apollo, son of Zeus and Leto, twin of Artemis, was the god of prophecy, medicine, music, art, law, beauty and wisdom. I guess getting to the moon required all that and more.'),('P112','Y Lab','17-06-2004','22-12-2015','Y Lab is addressing major public services challenges in Wales.');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-08 16:22:44
