-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user` (
  `iduser` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postalcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`tag` (
  `idtag` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtag`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `idvideo` INT NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `size` FLOAT NOT NULL,
  `filename` VARCHAR(45) NOT NULL,
  `length` TIME NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `playbacks` BIGINT NOT NULL,
  `likes` BIGINT NOT NULL,
  `dislikes` BIGINT NOT NULL,
  `accesstype` ENUM('PUBLIC', 'HIDDEN', 'PRIVATE') NOT NULL,
  `releasedate` DATETIME NOT NULL,
  `user` INT NOT NULL,
  `tag` INT NOT NULL,
  PRIMARY KEY (`idvideo`),
  UNIQUE INDEX `idvideo_UNIQUE` (`idvideo` ASC) VISIBLE,
  INDEX `user_idx` (`user` ASC) VISIBLE,
  INDEX `tag_idx` (`tag` ASC) VISIBLE,
  CONSTRAINT `uservideo`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tag`
    FOREIGN KEY (`tag`)
    REFERENCES `youtube`.`tag` (`idtag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channel` (
  `idchannel` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `dateofcreation` DATE NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`idchannel`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `userchannel`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`subscriptions` (
  `channel` INT NOT NULL,
  `user` INT NOT NULL,
  INDEX `channel_idx` (`channel` ASC) VISIBLE,
  INDEX `user_idx` (`user` ASC) VISIBLE,
  PRIMARY KEY (`channel`, `user`),
  CONSTRAINT `channelsubscriptions`
    FOREIGN KEY (`channel`)
    REFERENCES `youtube`.`channel` (`idchannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usersubscriptions`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`likestovideo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`likestovideo` (
  `like` ENUM('LIKE', 'DISLIKE') NOT NULL,
  `user` INT NOT NULL,
  `video` INT NOT NULL,
  `likedatetime` DATETIME NOT NULL,
  INDEX `user_idx` (`user` ASC) VISIBLE,
  INDEX `video_idx` (`video` ASC) VISIBLE,
  PRIMARY KEY (`user`, `video`),
  CONSTRAINT `userlikestovideo`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `videolikestovideo`
    FOREIGN KEY (`video`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `idplaylist` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `dateofcreation` DATE NOT NULL,
  `acces` ENUM('PUBLIC', 'PRIVATE') NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`idplaylist`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `userplaylist`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
  `idcomment` INT NOT NULL,
  `video` INT NOT NULL,
  `user` INT NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`idcomment`, `video`, `user`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `videocomments`
    FOREIGN KEY (`video`)
    REFERENCES `youtube`.`video` (`idvideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usercomments`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`likestocomments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`likestocomments` (
  `videocomment` INT NOT NULL,
  `usercomment` INT NOT NULL,
  `likeordislike` ENUM('LIKE', 'DISLIKE') NOT NULL,
  `datetimecomment` DATETIME NOT NULL,
  PRIMARY KEY (`videocomment`, `usercomment`),
  INDEX `usercomment_idx` (`usercomment` ASC) VISIBLE,
  CONSTRAINT `videocommentlikestocomments`
    FOREIGN KEY (`videocomment`)
    REFERENCES `youtube`.`comments` (`video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usercommentlikestocomment`
    FOREIGN KEY (`usercomment`)
    REFERENCES `youtube`.`comments` (`user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
