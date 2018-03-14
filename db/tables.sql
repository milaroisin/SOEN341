-- MySQL Script generated by MySQL Workbench
-- 02/10/18 16:51:49
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema 341
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 341
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `341` DEFAULT CHARACTER SET utf8 ;
USE `341` ;

-- -----------------------------------------------------
-- Table `341`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`user` ;

CREATE TABLE IF NOT EXISTS `341`.`user` (
  `user_id` INT(8) NOT NULL AUTO_INCREMENT,
  `user_creation_time` DATETIME DEFAULT NOW(),
  `user_name` VARCHAR(25) NOT NULL,
  `user_email` VARCHAR(75) NOT NULL,
  `user_pass` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `341`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`post` ;

CREATE TABLE IF NOT EXISTS `341`.`post` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `post_creation_time` DATETIME DEFAULT NOW(),
  `post_title` VARCHAR(45) NOT NULL,
  `post_content` TEXT(1000) NOT NULL,
  `post_nb_likes` INT(9) DEFAULT 0,
  `post_creator` INT(8) NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `post_creator_idx` (`post_creator` ASC),
  CONSTRAINT `post_creator`
    FOREIGN KEY (`post_creator`)
    REFERENCES `341`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `341`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`comment` ;

CREATE TABLE IF NOT EXISTS `341`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment_creation_time` DATETIME DEFAULT NOW(),
  `comment_content` TEXT(1000) NOT NULL,
  `comment_nb_likes` INT(9) DEFAULT 0,
  `comment_creator` INT(8) NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `post_creator_idx` (`comment_creator` ASC),
  CONSTRAINT `comment_creator0`
    FOREIGN KEY (`comment_creator`)
    REFERENCES `341`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `341`.`comment_comment_ass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`comment_comment_ass` ;

CREATE TABLE IF NOT EXISTS `341`.`comment_comment_ass` (
  `parent_id` INT(8) NOT NULL,
  `child_id` INT(8) NOT NULL,
  PRIMARY KEY (`parent_id`, `child_id`),
  INDEX `comment_id_idx` (`child_id` ASC),
  CONSTRAINT `parrent_id`
    FOREIGN KEY (`parent_id`)
    REFERENCES `341`.`comment` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `child_id`
    FOREIGN KEY (`child_id`)
    REFERENCES `341`.`comment` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `341`.`post_comment_ass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`post_comment_ass` ;

CREATE TABLE IF NOT EXISTS `341`.`post_comment_ass` (
  `post_id` INT(8) NOT NULL,
  `comment_id` INT(8) NOT NULL,
  PRIMARY KEY (`post_id`, `comment_id`),
  INDEX `comment_id_idx` (`comment_id` ASC),
  CONSTRAINT `post_id0`
    FOREIGN KEY (`post_id`)
    REFERENCES `341`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_id0`
    FOREIGN KEY (`comment_id`)
    REFERENCES `341`.`comment` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

	
-- -----------------------------------------------------
-- Table `341`.`contactus_email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`contactus_email` ;

CREATE TABLE IF NOT EXISTS `341`.`contactus_email` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `time` DATETIME DEFAULT NOW(),
  `subject` CHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `message` TEXT(1000) NOT NULL,
  `name` CHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_creator_idx` (`id` ASC)) ;
  
-- -----------------------------------------------------
-- Table `341`.`notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `341`.`notifications` ; 
  
CREATE TABLE `341`.`notifications` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `recipient_id` int(8) NOT NULL,
  `sender_id` int(8) NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(255) NOT NULL DEFAULT '',
  `created_at` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
