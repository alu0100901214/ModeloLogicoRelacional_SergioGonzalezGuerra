-- MySQL Script generated by MySQL Workbench
-- Fri Nov  6 18:53:42 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `DNI` INT NOT NULL,
  `Volumen compra` INT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Bonificación` INT NULL,
  `Lugar compra` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`),
  INDEX `Pide_idx` (`Lugar compra` ASC) VISIBLE,
  CONSTRAINT `Pide`
    FOREIGN KEY (`Lugar compra`)
    REFERENCES `mydb`.`Pedido` (`Lugar del pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `DNI` INT NOT NULL,
  `CSS` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Lugar de trabajo` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`, `CSS`),
  INDEX `Trabaja_idx` (`Lugar de trabajo` ASC) VISIBLE,
  CONSTRAINT `Trabaja`
    FOREIGN KEY (`Lugar de trabajo`)
    REFERENCES `mydb`.`Zonas` (`Nombre zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tramita`
    FOREIGN KEY (`Lugar de trabajo`)
    REFERENCES `mydb`.`Pedido` (`Lugar del pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `Lugar del pedido` VARCHAR(45) NOT NULL,
  `Fecha` DATE NULL,
  PRIMARY KEY (`Lugar del pedido`),
  CONSTRAINT `contiene`
    FOREIGN KEY (`Lugar del pedido`)
    REFERENCES `mydb`.`Producto` (`nombre zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `es solicitado`
    FOREIGN KEY (`Lugar del pedido`)
    REFERENCES `mydb`.`Cliente` (`Lugar compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `es tramitado`
    FOREIGN KEY (`Lugar del pedido`)
    REFERENCES `mydb`.`Empleado` (`Lugar de trabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `Código de barras` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `Precio` INT NULL,
  `Tipo` VARCHAR(45) NULL,
  `Caducidad` DATE NULL,
  `nombre zona` VARCHAR(45) NULL,
  PRIMARY KEY (`Código de barras`),
  INDEX `Asignado_idx` (`nombre zona` ASC) VISIBLE,
  CONSTRAINT `Asignado`
    FOREIGN KEY (`nombre zona`)
    REFERENCES `mydb`.`Zonas` (`Nombre zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Es solicitado`
    FOREIGN KEY (`nombre zona`)
    REFERENCES `mydb`.`Pedido` (`Lugar del pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zonas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zonas` (
  `Nombre zona` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`Nombre zona`),
  CONSTRAINT `Posee`
    FOREIGN KEY (`Nombre zona`)
    REFERENCES `mydb`.`Producto` (`nombre zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Contiene`
    FOREIGN KEY (`Nombre zona`)
    REFERENCES `mydb`.`vivero` (`Ubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Contiene`
    FOREIGN KEY (`Nombre zona`)
    REFERENCES `mydb`.`Empleado` (`Lugar de trabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vivero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vivero` (
  `Ubicacion` VARCHAR(60) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Horario de apertura` TIME NULL,
  `Horario de cierre` INT NULL,
  PRIMARY KEY (`Ubicacion`),
  CONSTRAINT `Contiene`
    FOREIGN KEY (`Ubicacion`)
    REFERENCES `mydb`.`Zonas` (`Nombre zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
