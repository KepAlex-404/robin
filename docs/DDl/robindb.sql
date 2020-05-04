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
  `user_id` VARCHAR(36) NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `display_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(40) NULL DEFAULT NULL,
  `password` VARCHAR(60) NULL DEFAULT NULL,
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
  `service_id` VARCHAR(36) NOT NULL,
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
  `develop_id` VARCHAR(36) NOT NULL,
  `developer_type` VARCHAR(50) NULL DEFAULT NULL,
  `promoted_by` VARCHAR(36) NULL DEFAULT NULL,
  `api_token` VARCHAR(36) NULL DEFAULT NULL,
  PRIMARY KEY (`develop_id`),
  INDEX `promoted_by` (`promoted_by` ASC) VISIBLE,
  INDEX `api_token` (`api_token` ASC) VISIBLE,
  CONSTRAINT `develop_ibfk_1`
    FOREIGN KEY (`promoted_by`)
    REFERENCES `robindb`.`user` (`user_id`),
  CONSTRAINT `develop_ibfk_2`
    FOREIGN KEY (`api_token`)
    REFERENCES `robindb`.`service` (`service_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`owner` (
  `owner_id` VARCHAR(36) NOT NULL,
  `ownership_type` VARCHAR(20) NULL DEFAULT NULL,
  `base_id` VARCHAR(36) NULL DEFAULT NULL,
  `promoted_by` VARCHAR(36) NULL DEFAULT NULL,
  `promoted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`owner_id`),
  INDEX `promoted_by` (`promoted_by` ASC) VISIBLE,
  CONSTRAINT `owner_ibfk_1`
    FOREIGN KEY (`promoted_by`)
    REFERENCES `robindb`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `robindb`.`opendata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `robindb`.`opendata` (
  `data_id` VARCHAR(36) NOT NULL,
  `adress` VARCHAR(50) NOT NULL,
  `data_type` VARCHAR(20) NULL DEFAULT NULL,
  `data_title` VARCHAR(35) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `version` VARCHAR(50) NULL DEFAULT NULL,
  `used_by` VARCHAR(36) NULL DEFAULT NULL,
  `total_rows` BIGINT UNSIGNED NULL DEFAULT NULL,
  `issues` TEXT NULL DEFAULT NULL,
  `first_publish` DATETIME NULL DEFAULT NULL,
  `last_publish` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`data_id`),
  INDEX `used_by` (`used_by` ASC) VISIBLE,
  CONSTRAINT `opendata_ibfk_1`
    FOREIGN KEY (`used_by`)
    REFERENCES `robindb`.`owner` (`owner_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
