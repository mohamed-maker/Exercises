-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema doctors
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doctors
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doctors` ;
USE `doctors` ;

-- -----------------------------------------------------
-- Table `doctors`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Specialist` (
  `specialist_id` INT NOT NULL,
  `field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`specialist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Medical` (
  `medical_id` INT NOT NULL,
  `overtime_rate` DATETIME NULL,
  PRIMARY KEY (`medical_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Doctor` (
  `Doctor_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `Salary` VARCHAR(45) NULL,
  `medical_id` INT NULL,
  `specialist_id` INT NULL,
  PRIMARY KEY (`Doctor_id`),
  INDEX `specialist_id_idx` (`specialist_id` ASC) VISIBLE,
  INDEX `medical_id_idx` (`medical_id` ASC) VISIBLE,
  CONSTRAINT `specialist_id`
    FOREIGN KEY (`specialist_id`)
    REFERENCES `doctors`.`Specialist` (`specialist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `medical_id`
    FOREIGN KEY (`medical_id`)
    REFERENCES `doctors`.`Medical` (`medical_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Payment` (
  `Payment_id` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`Payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Patient2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Patient2` (
  `patient_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `phone-number` INT NULL,
  `Date-of-birth` DATE NULL,
  `paymaint_id` INT NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `fk_Patient2_1_idx` (`paymaint_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient2_1`
    FOREIGN KEY (`paymaint_id`)
    REFERENCES `doctors`.`Payment` (`Payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Appointment` (
  `Appointment_id` INT NOT NULL,
  `Doctor_id` INT NULL,
  `Date` DATE NULL,
  `time` VARCHAR(45) NULL,
  `patient_id` INT NULL,
  PRIMARY KEY (`Appointment_id`),
  INDEX `fk_Appointment_1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_Appointment_2_idx` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `doctors`.`Patient2` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_2`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `doctors`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`Bill` (
  `total` INT NULL,
  `Bill_id` INT NOT NULL,
  PRIMARY KEY (`Bill_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doctors`.`money`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doctors`.`money` (
  `money_id` INT NOT NULL,
  `Payment_id` INT NULL,
  `Bill_id` INT NULL,
  PRIMARY KEY (`money_id`),
  INDEX `Bill_id_idx` (`Bill_id` ASC) VISIBLE,
  INDEX `payment_id_idx` (`Payment_id` ASC) VISIBLE,
  CONSTRAINT `payment_id`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `doctors`.`Payment` (`Payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Bill_id`
    FOREIGN KEY (`Bill_id`)
    REFERENCES `doctors`.`Bill` (`Bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
