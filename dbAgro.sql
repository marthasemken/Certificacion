-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dbAgro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbAgro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbAgro` DEFAULT CHARACTER SET utf8 ;
USE `dbAgro` ;

-- -----------------------------------------------------
-- Table `dbAgro`.`estado_campo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`estado_campo` (
  `nombre` VARCHAR(50) NOT NULL,
  `id_estado_campoco` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_estado_campoco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`campo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`campo` (
  `id_campo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `superficie` INT NULL,
  `id_estado_campo` INT NOT NULL,
  PRIMARY KEY (`id_campo`),
  INDEX `fk_campo_estado_campo_idx` (`id_estado_campo` ASC),
  CONSTRAINT `fk_campo_estado_campo`
    FOREIGN KEY (`id_estado_campo`)
    REFERENCES `dbAgro`.`estado_campo` (`id_estado_campoco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`plaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`plaga` (
  `id_plaga` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_plaga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`tipo_suelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`tipo_suelo` (
  `id_tipo_suelo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `caracteristicas` VARCHAR(250) NULL,
  PRIMARY KEY (`id_tipo_suelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`lote` (
  `id_lote` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_suelo` INT NOT NULL,
  `superficie` INT NULL,
  `id_campo` INT NULL,
  `numero` INT NULL,
  INDEX `fk_lote_tipo_suelo1_idx` (`id_tipo_suelo` ASC),
  INDEX `fk_lote_campo1_idx` (`id_campo` ASC),
  PRIMARY KEY (`id_lote`),
  CONSTRAINT `fk_lote_tipo_suelo1`
    FOREIGN KEY (`id_tipo_suelo`)
    REFERENCES `dbAgro`.`tipo_suelo` (`id_tipo_suelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lote_campo1`
    FOREIGN KEY (`id_campo`)
    REFERENCES `dbAgro`.`campo` (`id_campo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`cultivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`cultivo` (
  `id_cultivo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `id_tipo_suelo` INT NOT NULL,
  PRIMARY KEY (`id_cultivo`),
  INDEX `fk_cultivo_tipo_suelo1_idx` (`id_tipo_suelo` ASC),
  CONSTRAINT `fk_cultivo_tipo_suelo1`
    FOREIGN KEY (`id_tipo_suelo`)
    REFERENCES `dbAgro`.`tipo_suelo` (`id_tipo_suelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`estado_proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`estado_proyecto` (
  `id_estado_proyecto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado_proyecto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `id_lote` INT NOT NULL,
  `id_cultivo` INT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `id_estado_proyecto` INT NULL,
  `fecha_fin` INT NULL,
  PRIMARY KEY (`idproyecto`),
  INDEX `fk_proyecto_estado_proyecto1_idx` (`id_estado_proyecto` ASC),
  INDEX `fk_proyecto_cultivo1_idx` (`id_cultivo` ASC),
  INDEX `fk_proyecto_lote1_idx` (`id_lote` ASC),
  CONSTRAINT `fk_proyecto_estado_proyecto1`
    FOREIGN KEY (`id_estado_proyecto`)
    REFERENCES `dbAgro`.`estado_proyecto` (`id_estado_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_cultivo1`
    FOREIGN KEY (`id_cultivo`)
    REFERENCES `dbAgro`.`cultivo` (`id_cultivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_lote1`
    FOREIGN KEY (`id_lote`)
    REFERENCES `dbAgro`.`lote` (`id_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`agroquimico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`agroquimico` (
  `id_agroquimico` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(250) NULL,
  PRIMARY KEY (`id_agroquimico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`tratamiento` (
  `id_tratamiento` INT NOT NULL AUTO_INCREMENT,
  `id_agroquimico` INT NULL,
  `dosis` INT NULL,
  PRIMARY KEY (`id_tratamiento`),
  INDEX `fk_tratamiento_agroquimico1_idx` (`id_agroquimico` ASC),
  CONSTRAINT `fk_tratamiento_agroquimico1`
    FOREIGN KEY (`id_agroquimico`)
    REFERENCES `dbAgro`.`agroquimico` (`id_agroquimico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`tratamiento_plaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`tratamiento_plaga` (
  `id_plaga` INT NOT NULL,
  `id_tratamiento` INT NOT NULL,
  PRIMARY KEY (`id_plaga`, `id_tratamiento`),
  INDEX `fk_tratamiento_plaga_tratamiento1_idx` (`id_tratamiento` ASC),
  CONSTRAINT `fk_tratamiento_plaga_plaga1`
    FOREIGN KEY (`id_plaga`)
    REFERENCES `dbAgro`.`plaga` (`id_plaga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tratamiento_plaga_tratamiento1`
    FOREIGN KEY (`id_tratamiento`)
    REFERENCES `dbAgro`.`tratamiento` (`id_tratamiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`plaga_cultimo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`plaga_cultimo` (
  `id_plaga` INT NOT NULL,
  `id_cultivo` INT NOT NULL,
  PRIMARY KEY (`id_plaga`, `id_cultivo`),
  INDEX `fk_plaga_cultimo_cultivo1_idx` (`id_cultivo` ASC),
  CONSTRAINT `fk_plaga_cultimo_plaga1`
    FOREIGN KEY (`id_plaga`)
    REFERENCES `dbAgro`.`plaga` (`id_plaga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plaga_cultimo_cultivo1`
    FOREIGN KEY (`id_cultivo`)
    REFERENCES `dbAgro`.`cultivo` (`id_cultivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`tipo_laboreo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`tipo_laboreo` (
  `id_tipo_laboreo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_laboreo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbAgro`.`laboreo_cultivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbAgro`.`laboreo_cultivo` (
  `id_laboreo_cultivo` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_laboreo` INT NULL,
  `fecha` DATE NULL,
  `id_cultivo` INT NULL,
  PRIMARY KEY (`id_laboreo_cultivo`),
  INDEX `fk_laboreo_cultivo_tipo_laboreo1_idx` (`id_tipo_laboreo` ASC),
  INDEX `fk_laboreo_cultivo_cultivo1_idx` (`id_cultivo` ASC),
  CONSTRAINT `fk_laboreo_cultivo_tipo_laboreo1`
    FOREIGN KEY (`id_tipo_laboreo`)
    REFERENCES `dbAgro`.`tipo_laboreo` (`id_tipo_laboreo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laboreo_cultivo_cultivo1`
    FOREIGN KEY (`id_cultivo`)
    REFERENCES `dbAgro`.`cultivo` (`id_cultivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
