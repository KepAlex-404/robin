-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema robindb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema robindb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `robindb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `robindb` ;

-- -----------------------------------------------------
-- Table `robindb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`user` (
  `user_id` varchar (255) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `display_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `ispro` TINYINT(1) NOT NULL DEFAULT '0',
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`service` (
  `service_id` varchar(255) NOT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `description` VARCHAR(36) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`service_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`develop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`develop` (
  `developer_id` varchar(255) NOT NULL,
  `developer_type` VARCHAR(50) NULL DEFAULT NULL,
  `promoted_by` VARCHAR(36) NULL DEFAULT NULL,
  `api_token` VARCHAR(36) NULL DEFAULT NULL,
	`service_id` varchar(255) null default null,
  INDEX `promoted_by` (`promoted_by` ASC) VISIBLE,
  INDEX `api_token` (`api_token` ASC) VISIBLE,
  CONSTRAINT `develop_ibfk_1`
    FOREIGN KEY (`promoted_by`)
    REFERENCES `robindb`.`user` (`user_id`),
	FOREIGN KEY (`developer_id`)
    REFERENCES `robindb`.`user` (`user_id`),
    FOREIGN KEY (`service_id`)
    REFERENCES `robindb`.`service` (`service_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`owner` (
  `ownership_type` VARCHAR(20) NULL DEFAULT NULL,
  `base_id` varchar(255) NULL DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `promoted_by` VARCHAR(36) NULL DEFAULT NULL,
  `promoted_at` DATETIME NULL DEFAULT NULL,
  INDEX `promoted_by` (`promoted_by` ASC) VISIBLE,
  CONSTRAINT `owner_ibfk_1`
	FOREIGN KEY(`base_id`) 
	REFERENCES `robindb`.`OpenData` (`data_id`),
	 FOREIGN KEY (`promoted_by`)
    REFERENCES `robindb`.`user` (`user_id`),
	 FOREIGN KEY (`user_id`)
    REFERENCES `robindb`.`user` (`user_id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`opendata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`opendata` (
  `data_id` varchar(255) NOT NULL,
  `adress` VARCHAR(100) NOT NULL,
  `data_type` VARCHAR(50) NULL DEFAULT NULL,
  `data_title` VARCHAR(35) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `version` VARCHAR(15) NULL DEFAULT NULL,
  `used_by` int  NULL DEFAULT NULL,
  `total_rows` int  NULL DEFAULT NULL,
  `first_publish` DATETIME NULL DEFAULT NULL,
  `last_publish` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`data_id`),
  INDEX `used_by` (`used_by` ASC) VISIBLE
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
