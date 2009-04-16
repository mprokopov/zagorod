-- MySQL dump 9.11
--
-- Host: localhost    Database: userstamp_test
-- ------------------------------------------------------
-- Server version	4.0.24

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS states;
CREATE TABLE states (
  id int(11) NOT NULL auto_increment,
  name varchar(255),
  abbreviation varchar(255),
  PRIMARY KEY  (id)
) TYPE=MyISAM;
