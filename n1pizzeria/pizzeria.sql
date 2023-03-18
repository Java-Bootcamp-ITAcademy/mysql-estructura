-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`shopaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`shopaddress` (
  `idshopaddress` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `floor` VARCHAR(45) NULL DEFAULT NULL,
  `door` VARCHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idshopaddress`),
  UNIQUE INDEX `idadreça_UNIQUE` (`idshopaddress` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientaddress` (
  `idclientaddress` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `floor` VARCHAR(45) NULL DEFAULT NULL,
  `door` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idclientaddress`),
  UNIQUE INDEX `idadreça_UNIQUE` (`idclientaddress` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`drink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`drink` (
  `iddrink` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`iddrink`),
  UNIQUE INDEX `idbeguda_UNIQUE` (`iddrink` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`province` (
  `idprovince` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovince`),
  UNIQUE INDEX `idprovincia_UNIQUE` (`idprovince` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`city` (
  `idcity` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `province` INT NOT NULL,
  PRIMARY KEY (`idcity`),
  UNIQUE INDEX `idlocalitat_UNIQUE` (`idcity` ASC) VISIBLE,
  INDEX `provincia_idx` (`province` ASC) VISIBLE,
  CONSTRAINT `province`
    FOREIGN KEY (`province`)
    REFERENCES `pizzeria`.`province` (`idprovince`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`shop` (
  `idshop` INT NOT NULL,
  `shopaddress` INT NOT NULL,
  `postalcode` VARCHAR(5) NOT NULL,
  `city` INT NOT NULL,
  PRIMARY KEY (`idshop`),
  UNIQUE INDEX `idbotiga_UNIQUE` (`idshop` ASC) VISIBLE,
  UNIQUE INDEX `adreçabotiga_UNIQUE` (`shopaddress` ASC) VISIBLE,
  INDEX `adreçabotiga_idx` (`shopaddress` ASC) VISIBLE,
  INDEX `localitat_idx` (`city` ASC) VISIBLE,
  CONSTRAINT `shopaddress`
    FOREIGN KEY (`shopaddress`)
    REFERENCES `pizzeria`.`shopaddress` (`idshopaddress`),
  CONSTRAINT `cityshop`
    FOREIGN KEY (`city`)
    REFERENCES `pizzeria`.`city` (`idcity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzacategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzacategory` (
  `idpizzacategory` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpizzacategory`),
  UNIQUE INDEX `idcategoriapizza_UNIQUE` (`idpizzacategory` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `idcustomer` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `customeraddress` INT NOT NULL,
  `postalcode` VARCHAR(45) NOT NULL,
  `city` INT NOT NULL,
  `phone` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idcustomer`),
  UNIQUE INDEX `idclient_UNIQUE` (`idcustomer` ASC) VISIBLE,
  UNIQUE INDEX `adreçaclient_UNIQUE` (`customeraddress` ASC) VISIBLE,
  INDEX `adreça_idx` (`customeraddress` ASC) VISIBLE,
  INDEX `localitat_idx` (`city` ASC) VISIBLE,
  CONSTRAINT `customeraddress`
    FOREIGN KEY (`customeraddress`)
    REFERENCES `pizzeria`.`clientaddress` (`idclientaddress`),
  CONSTRAINT `citycustomer`
    FOREIGN KEY (`city`)
    REFERENCES `pizzeria`.`city` (`idcity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `idemployee` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(9) NOT NULL,
  `phone` VARCHAR(9) NOT NULL,
  `job` ENUM('CUINER', 'REPARTIDOR') NOT NULL,
  `shop` INT NOT NULL,
  PRIMARY KEY (`idemployee`),
  UNIQUE INDEX `idempleat_UNIQUE` (`idemployee` ASC) VISIBLE,
  INDEX `botiga_idx` (`shop` ASC) VISIBLE,
  CONSTRAINT `shop`
    FOREIGN KEY (`shop`)
    REFERENCES `pizzeria`.`shop` (`idshop`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguer` (
  `idhamburguer` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`idhamburguer`),
  UNIQUE INDEX `idhamburguesa_UNIQUE` (`idhamburguer` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `idpizza` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `image` BLOB NOT NULL,
  `price` FLOAT NOT NULL,
  `category` INT NOT NULL,
  PRIMARY KEY (`idpizza`),
  UNIQUE INDEX `idbeguda_UNIQUE` (`idpizza` ASC) VISIBLE,
  INDEX `categoria_idx` (`category` ASC) VISIBLE,
  CONSTRAINT `category`
    FOREIGN KEY (`category`)
    REFERENCES `pizzeria`.`pizzacategory` (`idpizzacategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `idcomanda` INT NOT NULL,
  `dateandtime` DATETIME NOT NULL,
  `place` ENUM('DOMICILI', 'RECOLLIR') NOT NULL,
  `npizzas` INT NOT NULL DEFAULT '0',
  `nhamburguers` INT NOT NULL DEFAULT '0',
  `ndrinks` INT NOT NULL DEFAULT '0',
  `amount` DOUBLE NOT NULL DEFAULT '0',
  `customer` INT NOT NULL,
  `hamburguer` INT NOT NULL,
  `pizza` INT NOT NULL,
  `drink` INT NOT NULL,
  `deliverytime` DATETIME NULL DEFAULT NULL,
  `delivery` INT NULL DEFAULT NULL,
  `employee` INT NOT NULL,
  PRIMARY KEY (`idcomanda`),
  UNIQUE INDEX `idcomanda_UNIQUE` (`idcomanda` ASC) VISIBLE,
  INDEX `client_idx` (`customer` ASC) VISIBLE,
  INDEX `hamburguesa_idx` (`hamburguer` ASC) VISIBLE,
  INDEX `beguda_idx` (`drink` ASC) VISIBLE,
  INDEX `pizza_idx` (`pizza` ASC) VISIBLE,
  INDEX `empleat_idx` (`employee` ASC) VISIBLE,
  INDEX `delivery_idx` (`delivery` ASC) VISIBLE,
  CONSTRAINT `drink`
    FOREIGN KEY (`drink`)
    REFERENCES `pizzeria`.`drink` (`iddrink`),
  CONSTRAINT `customer`
    FOREIGN KEY (`customer`)
    REFERENCES `pizzeria`.`customer` (`idcustomer`),
  CONSTRAINT `employee`
    FOREIGN KEY (`employee`)
    REFERENCES `pizzeria`.`employee` (`idemployee`),
  CONSTRAINT `hamburguer`
    FOREIGN KEY (`hamburguer`)
    REFERENCES `pizzeria`.`hamburguer` (`idhamburguer`),
  CONSTRAINT `pizza`
    FOREIGN KEY (`pizza`)
    REFERENCES `pizzeria`.`pizza` (`idpizza`),
  CONSTRAINT `delivery`
    FOREIGN KEY (`delivery`)
    REFERENCES `pizzeria`.`employee` (`idemployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
