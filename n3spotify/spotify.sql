-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user` (
  `iduser` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `postalcode` VARCHAR(9) NOT NULL,
  `type` ENUM('FREE', 'PREMIUM') NOT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscription` (
  `idsubscription` INT NOT NULL,
  `user` INT NOT NULL,
  `startdate` DATE NOT NULL,
  `renewaldate` DATE NOT NULL,
  `paymentmethod` ENUM('CREDITCARD', 'PAYPAL') NOT NULL,
  PRIMARY KEY (`idsubscription`, `user`),
  CONSTRAINT `usersubscription`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`creditcard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`creditcard` (
  `idcreditcard` INT NOT NULL,
  `number` VARCHAR(16) NOT NULL,
  `expirationmonth` VARCHAR(15) NOT NULL,
  `expirationyear` BIGINT NOT NULL,
  `ccv` INT NOT NULL,
  PRIMARY KEY (`idcreditcard`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `idpaypal` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpaypal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`payment` (
  `idpayment` INT NOT NULL,
  `paymentmethod` ENUM('CREDITCARD', 'PAYPAl') NOT NULL,
  `date` DATE NOT NULL,
  `amount` FLOAT NOT NULL,
  `creditcard` INT NULL,
  `paypal` INT NULL,
  `subscription` INT NOT NULL,
  PRIMARY KEY (`idpayment`, `subscription`),
  UNIQUE INDEX `paymentmethod_UNIQUE` (`paymentmethod` ASC) VISIBLE,
  INDEX `paypal_idx` (`paypal` ASC) VISIBLE,
  INDEX `creditcard_idx` (`creditcard` ASC) VISIBLE,
  INDEX `subscription_idx` (`subscription` ASC) VISIBLE,
  CONSTRAINT `paypalpayment`
    FOREIGN KEY (`paypal`)
    REFERENCES `spotify`.`paypal` (`idpaypal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `creditcardpayment`
    FOREIGN KEY (`creditcard`)
    REFERENCES `spotify`.`creditcard` (`idcreditcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `subscriptionpayment`
    FOREIGN KEY (`subscription`)
    REFERENCES `spotify`.`subscription` (`user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`activeplaylist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`activeplaylist` (
  `idplaylist` INT NOT NULL,
  `user` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `numberoftracks` INT NOT NULL,
  `creationdate` DATE NOT NULL,
  PRIMARY KEY (`idplaylist`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `useractiveplaylist`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`deletedplaylist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`deletedplaylist` (
  `iddeletedplaylist` INT NOT NULL,
  `user` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `numberoftracks` INT NOT NULL,
  `creationdate` DATE NOT NULL,
  `deletiondate` DATE NOT NULL,
  PRIMARY KEY (`iddeletedplaylist`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `userdeletedplaylist`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `idalbum` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `year` VARCHAR(4) NOT NULL,
  `cover` BLOB NOT NULL,
  PRIMARY KEY (`idalbum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist` (
  `idartist` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`idartist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`track` (
  `idtrack` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `length` TIME NOT NULL,
  `album` INT NOT NULL,
  `played` VARCHAR(45) NOT NULL,
  `artist` INT NOT NULL,
  PRIMARY KEY (`idtrack`),
  INDEX `album_idx` (`album` ASC) VISIBLE,
  INDEX `artist_idx` (`artist` ASC) VISIBLE,
  CONSTRAINT `albumtrack`
    FOREIGN KEY (`album`)
    REFERENCES `spotify`.`album` (`idalbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artisttrack`
    FOREIGN KEY (`artist`)
    REFERENCES `spotify`.`artist` (`idartist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`trackaddition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`trackaddition` (
  `idtrackaddition` INT NOT NULL,
  `activeplaylist` INT NOT NULL,
  `user` INT NOT NULL,
  `date` DATE NOT NULL,
  `track` INT NOT NULL,
  PRIMARY KEY (`idtrackaddition`, `activeplaylist`, `track`, `user`),
  INDEX `activeplaylist_idx` (`activeplaylist` ASC) VISIBLE,
  INDEX `user_idx` (`user` ASC) VISIBLE,
  INDEX `track_idx` (`track` ASC) VISIBLE,
  CONSTRAINT `activeplaylisttrackaddition`
    FOREIGN KEY (`activeplaylist`)
    REFERENCES `spotify`.`activeplaylist` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usertrackaddition`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tracktrackaddition`
    FOREIGN KEY (`track`)
    REFERENCES `spotify`.`track` (`idtrack`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistrelated`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistrelated` (
  `artist` INT NOT NULL,
  `artistrelated` INT NOT NULL,
  PRIMARY KEY (`artist`, `artistrelated`),
  INDEX `artistrelated_idx` (`artistrelated` ASC) VISIBLE,
  CONSTRAINT `artistartistrelated`
    FOREIGN KEY (`artist`)
    REFERENCES `spotify`.`artist` (`idartist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artistrelatedartist`
    FOREIGN KEY (`artistrelated`)
    REFERENCES `spotify`.`artist` (`idartist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`favouritealbum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`favouritealbum` (
  `album` INT NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`album`, `user`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `albumfavouritealbum`
    FOREIGN KEY (`album`)
    REFERENCES `spotify`.`album` (`idalbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userfavouritealbum`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`favouritetrack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`favouritetrack` (
  `track` INT NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`track`, `user`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `trackfavouritetrack`
    FOREIGN KEY (`track`)
    REFERENCES `spotify`.`track` (`idtrack`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userfavouritetrack`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`userfollowingartist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`userfollowingartist` (
  `user` INT NOT NULL,
  `artist` INT NOT NULL,
  PRIMARY KEY (`user`, `artist`),
  INDEX `artist_idx` (`artist` ASC) VISIBLE,
  CONSTRAINT `useruserfollowingartist`
    FOREIGN KEY (`user`)
    REFERENCES `spotify`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artistuserfollowingartist`
    FOREIGN KEY (`artist`)
    REFERENCES `spotify`.`artist` (`idartist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
