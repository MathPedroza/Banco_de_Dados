-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema apicultura
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema apicultura
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `apicultura` DEFAULT CHARACTER SET utf8 ;
USE `apicultura` ;

-- -----------------------------------------------------
-- Table `apicultura`.`apicultor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apicultura`.`apicultor` (
  `idapicultor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idapicultor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apicultura`.`apiario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apicultura`.`apiario` (
  `idapiario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `apicultor_idapicultor` INT NOT NULL,
  PRIMARY KEY (`idapiario`, `apicultor_idapicultor`))
ENGINE = InnoDB;

ALTER TABLE apiario ADD
FOREIGN KEY (apicultor_idapicultor) REFERENCES apicultor(idapicultor);

-- -----------------------------------------------------
-- Table `apicultura`.`colmeia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apicultura`.`colmeia` (
  `idcolmeia` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `qtd_melgueiras` INT NOT NULL,
  `abelha_rainha` VARCHAR(45) NOT NULL,
  `apiario_idapiario` INT NOT NULL,
  PRIMARY KEY (`idcolmeia`, `apiario_idapiario`))
ENGINE = InnoDB;

ALTER TABLE colmeia ADD
FOREIGN KEY (apiario_idapiario) REFERENCES apiario(idapiario);

-- -----------------------------------------------------
-- Table `apicultura`.`extracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apicultura`.`extracao` (
  `idextracao` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `mel(kg)` DOUBLE NULL,
  `propolis(gr)` DOUBLE NULL,
  `colmeia_idcolmeia` INT NOT NULL,
  PRIMARY KEY (`idextracao`, `colmeia_idcolmeia`))
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




-----------------------------------------------------------------------------
-- Felipe Navas
-- Guilherme Fontana
-----------------------------------------------------------------------------


-- apicultores
INSERT INTO apicultor VALUES ("1", "Deoclecio");
INSERT INTO apicultor VALUES ("2", "Petronio");
INSERT INTO apicultor VALUES ("3", "Gabriel");

-- apiarios
INSERT INTO apiario VALUES ("1", "Pratinha", "1");
INSERT INTO apiario VALUES ("2", "Cerrado", "2");
INSERT INTO apiario VALUES ("3", "Mata do Felizbino", "3");
INSERT INTO apiario VALUES ("4", "Biguatinga", "1");


-- colmeias no apiario  id = 4
INSERT INTO colmeia VALUES ("1", "1", "0", "sim", "4");
INSERT INTO colmeia VALUES ("2", "2", "1", "sim", "4");
INSERT INTO colmeia VALUES ("3", "3", "1", "nao", "4");
INSERT INTO colmeia VALUES ("4", "4", "2", "sim", "4");
INSERT INTO colmeia VALUES ("5", "5", "0", "nao", "4");
-- colmeias no apiario  id = 1
INSERT INTO colmeia VALUES ("6", "1", "1", "sim", "1");
INSERT INTO colmeia VALUES ("7", "2", "2", "sim", "1");
INSERT INTO colmeia VALUES ("8", "3", "3", "nao", "1");
-- colmeias no apiario  id = 2
INSERT INTO colmeia VALUES ("9", "1", "0", "sim", "2");
INSERT INTO colmeia VALUES ("10", "2", "2", "nao", "2");
INSERT INTO colmeia VALUES ("11", "4", "1", "nao", "2");
-- colmeias no apiario  id = 3
INSERT INTO colmeia VALUES ("12", "1", "2", "sim", "3");
INSERT INTO colmeia VALUES ("13", "3", "3", "sim", "3");

-- extrações no apiario id 1-5
INSERT INTO extracao VALUES ("1", "20200623", "0", "250", "1");
INSERT INTO extracao VALUES ("2", "20200623", "0", "150", "2");
INSERT INTO extracao VALUES ("3", "20200623", "0", "75", "3");
INSERT INTO extracao VALUES ("4", "20200623", "0", "370", "4");
INSERT INTO extracao VALUES ("5", "20200623", "0", "180", "5");
-- extrações no apiario id 6-8
INSERT INTO extracao VALUES ("6", "20200621", "0", "125", "6");
INSERT INTO extracao VALUES ("7", "20200621", "0", "195", "7");
INSERT INTO extracao VALUES ("8", "20200621", "0", "0", "8");
-- extrações no apiario id 9-11
INSERT INTO extracao VALUES ("9", "20200623", "5", "0", "9");
INSERT INTO extracao VALUES ("10", "20200623", "7", "0", "10");
INSERT INTO extracao VALUES ("11", "20200623", "3", "0", "11");
-- extrações no apiario id 12-13
INSERT INTO extracao VALUES ("12", "20200625", "0", "320", "12");
INSERT INTO extracao VALUES ("13", "20200625", "0", "280", "13");

-- 3) Quantidade de melgueiras por apiario:
-- É importante saber a quantidade de melgueiras para se ter um controle de quão grande está
-- o apiário, pois há um limite de colméias por km.
SELECT ap.nome AS "apicultor", a.nome AS "apiario", SUM(c.qtd_melgueiras) AS "qtd melgueiras"
FROM apiario a
INNER JOIN colmeia c
ON a.idapiario = c.apiario_idapiario
INNER JOIN apicultor ap
ON ap.idapicultor = a.apicultor_idapicultor
GROUP BY ap.nome, a.nome;

-- 3) Verificar avistamentos da abelha rainha:
-- É importante que se tenha um monitoramento cuidadoso com a abelha rainha, pois a falta dela
-- pode implicar em um enxame que logo se enfraquecerá, podendo perdê-lo.
SELECT a.nome AS "apiario", c.idcolmeia AS "numero colmeia"
FROM apiario a
INNER JOIN colmeia c
ON a.idapiario = c.apiario_idapiario
WHERE c.abelha_rainha = "nao"
GROUP BY a.nome, c.idcolmeia;

-- 4) Trigger para excluir as colmeias quando um apiario é excluido:
delimiter |
create trigger exclui_col
before delete on apiario
for each ROW
begin
delete from colmeia where idapiario = old.idapiario;
end
|
delimiter ;

DELETE FROM apiario
WHERE idapiario = 4;

