-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`customeraddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`customeraddress` (
  `idadress` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(1) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalcode` VARCHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idadress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`customer` (
  `idcustomer` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(9) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registerdate` DATE NOT NULL,
  `cutomerrecomendation` INT NULL DEFAULT NULL,
  `address` INT NOT NULL,
  PRIMARY KEY (`idcustomer`),
  INDEX `clientrecomanat_idx` (`cutomerrecomendation` ASC) VISIBLE,
  INDEX `adreçaclient_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `customeraddress`
    FOREIGN KEY (`address`)
    REFERENCES `optica`.`customeraddress` (`idadress`),
  CONSTRAINT `customerrecomendation`
    FOREIGN KEY (`cutomerrecomendation`)
    REFERENCES `optica`.`customer` (`idcustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`provideraddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`provideraddress` (
  `idadress` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(1) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `codipostal` VARCHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idadress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`provider` (
  `idprovider` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` INT NOT NULL,
  `phone` VARCHAR(9) NOT NULL,
  `FAX` VARCHAR(9) NULL DEFAULT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idprovider`),
  INDEX `adreça_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `provideraddress`
    FOREIGN KEY (`address`)
    REFERENCES `optica`.`provideraddress` (`idadress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`seller` (
  `idseller` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idseller`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`glasses` (
  `idglasses` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `rightdiopters` FLOAT NOT NULL,
  `frametype` ENUM('FLOTANT', 'PASTA', 'METALLICA') NOT NULL,
  `framecolour` VARCHAR(45) NOT NULL,
  `glassclolour` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `provider` INT NOT NULL,
  `customer` INT NOT NULL,
  `leftdiopters` FLOAT NOT NULL,
  `seller` INT NOT NULL,
  `dateofsale` DATETIME NOT NULL,
  PRIMARY KEY (`idglasses`),
  INDEX `proveidor_idx` (`provider` ASC) VISIBLE,
  INDEX `client_idx` (`customer` ASC) VISIBLE,
  INDEX `venedor_idx` (`seller` ASC) VISIBLE,
  CONSTRAINT `customer`
    FOREIGN KEY (`customer`)
    REFERENCES `optica`.`customer` (`idcustomer`),
  CONSTRAINT `provider`
    FOREIGN KEY (`provider`)
    REFERENCES `optica`.`provider` (`idprovider`),
  CONSTRAINT `seller`
    FOREIGN KEY (`seller`)
    REFERENCES `optica`.`seller` (`idseller`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
