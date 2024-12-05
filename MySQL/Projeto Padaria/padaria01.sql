CREATE DATABASE padariaead; USE padariaead;

--
CREATE TABLE Ingredientes (
 idIngredientes INTEGER NOT NULL,
 Nome VARCHAR(40) NULL,
 QtdeEstoque DECIMAL(8,2) NULL, PRIMARY KEY(idIngredientes)
);
CREATE TABLE Cozinheiro (
 idCozinheiro INTEGER NOT NULL,
 Nome VARCHAR(40) NULL,
 Sexo CHAR(1) NULL,
 Salario DECIMAL(8,2) NULL, PRIMARY KEY(idCozinheiro)
);
CREATE TABLE Prato (
 idPrato INTEGER NOT NULL,
 idCozinheiro INTEGER NOT NULL,
 Nome VARCHAR(40) NULL,
 Preco DECIMAL(8,2) NULL, PRIMARY KEY(idPrato), INDEX Prato_FKIndex1(idCozinheiro), FOREIGN KEY(idCozinheiro) REFERENCES Cozinheiro(idCozinheiro) ON
DELETE NO ACTION ON
UPDATE NO ACTION
);
CREATE TABLE Receita (
 idPrato INTEGER NOT NULL,
 idIngredientes INTEGER NOT NULL, PRIMARY KEY(idPrato, idIngredientes), INDEX Receita_FKIndex1(idPrato), INDEX Receita_FKIndex2(idIngredientes), FOREIGN KEY(idPrato) REFERENCES Prato(idPrato) ON
DELETE NO ACTION ON
UPDATE NO ACTION, FOREIGN KEY(idIngredientes) REFERENCES Ingredientes(idIngredientes) ON
DELETE NO ACTION ON
UPDATE NO ACTION
);

--
DESCRIBE cozinheiro;
INSERT INTO cozinheiro VALUES (1,'Joao','M',1500.00);
INSERT INTO cozinheiro VALUES (2,'Jose','M',1600.00);
INSERT INTO cozinheiro VALUES (3,'Ana','M',900.00);
INSERT INTO cozinheiro VALUES (4,'Ricardo','M',1800.00);
INSERT INTO cozinheiro VALUES (5,'Alberto','M',17000.00);
INSERT INTO cozinheiro VALUES (6,'Fernando','M',17000.00);
SELECT *
FROM cozinheiro; DESCRIBE ingredientes;
INSERT INTO ingredientes VALUES (1,'Ovo',500);
INSERT INTO ingredientes VALUES (2,'Farinha',1500);
INSERT INTO ingredientes VALUES (3,'Leite',2500);
INSERT INTO ingredientes VALUES (4,'Sal',300);
INSERT INTO ingredientes VALUES (5,'Coco',600);
INSERT INTO ingredientes VALUES (6,'Carne Moida',1000);
INSERT INTO ingredientes VALUES (7,'Cebolinha',300);
INSERT INTO ingredientes VALUES (8,'Cereja',450);
INSERT INTO ingredientes VALUES (9,'Salsinha',600);
INSERT INTO ingredientes VALUES (10,'Creme de Leite',200);
INSERT INTO ingredientes VALUES (11,'Leite Condensado',660);
INSERT INTO ingredientes VALUES (12,'Farinha de rosca',300);
INSERT INTO ingredientes VALUES (13,'Leite em pó',630);
INSERT INTO ingredientes VALUES (14,'Chocolate',100);
INSERT INTO ingredientes VALUES (15,'Doce de leite',350);
INSERT INTO ingredientes VALUES (16,'Açucar',20);
INSERT INTO ingredientes VALUES (17,'Cebola',600);
INSERT INTO ingredientes VALUES (18,'Aliche',300);
INSERT INTO ingredientes VALUES (19,'Escarola',200);
SELECT *
FROM ingredientes; DESCRIBE prato;
INSERT INTO prato VALUES (1,1,'Quindim',5.00);
INSERT INTO prato VALUES (2,1,'Coxinha',3.00);
INSERT INTO prato VALUES (3,2,'Risoles',3.00);
INSERT INTO prato VALUES (4,4,'Kibe',3.00);
INSERT INTO prato VALUES (5,3,'Hamburguer',3.00);
INSERT INTO prato VALUES (6,5,'Bolo',4.00);
INSERT INTO prato VALUES (7,5,'Pão',0.30);
INSERT INTO prato VALUES (8,2,'Rosca',2.00);
INSERT INTO prato VALUES (9,4,'Pão de queijo',1.00);
INSERT INTO prato VALUES (10,3,'Lasanha',10.00);
INSERT INTO prato VALUES (11,3,'Nhoque',12.00);
INSERT INTO prato VALUES (12,2,'Pudim',8.00);
INSERT INTO prato VALUES (13,1,'Pudim',8.00);
INSERT INTO prato VALUES (14,1,'Pudim',8.00);
SELECT *
FROM prato; DESCRIBE receita;
INSERT INTO receita VALUES (1,1);
INSERT INTO receita VALUES (1,3);
INSERT INTO receita VALUES (1,4);
INSERT INTO receita VALUES (1,5);
INSERT INTO receita VALUES (2,3);
INSERT INTO receita VALUES (2,6);
INSERT INTO receita VALUES (2,9);
INSERT INTO receita VALUES (2,12);
INSERT INTO receita VALUES (3,2);
INSERT INTO receita VALUES (3,5);
INSERT INTO receita VALUES (3,7);
INSERT INTO receita VALUES (3,13);
INSERT INTO receita VALUES (4,14);
INSERT INTO receita VALUES (4,13);
INSERT INTO receita VALUES (4,2);
INSERT INTO receita VALUES (4,1);
INSERT INTO receita VALUES (5,3);
INSERT INTO receita VALUES (5,4);
INSERT INTO receita VALUES (5,16);
INSERT INTO receita VALUES (5,14);
INSERT INTO receita VALUES (6,9);
INSERT INTO receita VALUES (6,7);
INSERT INTO receita VALUES (6,4);
INSERT INTO receita VALUES (6,5);
INSERT INTO receita VALUES (7,3);
INSERT INTO receita VALUES (7,2);
INSERT INTO receita VALUES (7,11);
INSERT INTO receita VALUES (7,14);
INSERT INTO receita VALUES (8,15);
INSERT INTO receita VALUES (8,13);
INSERT INTO receita VALUES (8,3);
INSERT INTO receita VALUES (8,11);
INSERT INTO receita VALUES (9,4);
INSERT INTO receita VALUES (9,7);
INSERT INTO receita VALUES (9,14);
INSERT INTO receita VALUES (9,8);
INSERT INTO receita VALUES (10,9);
INSERT INTO receita VALUES (10,15);
INSERT INTO receita VALUES (10,11);
INSERT INTO receita VALUES (10,3);
INSERT INTO receita VALUES (11,2);
INSERT INTO receita VALUES (11,4);
INSERT INTO receita VALUES (11,12);
INSERT INTO receita VALUES (11,16);
INSERT INTO receita VALUES (12,2);
INSERT INTO receita VALUES (12,5);
INSERT INTO receita VALUES (12,7);
INSERT INTO receita VALUES (12,9);
SELECT *
FROM receita;

--

-- Quais pratos utilizam ovo?
SELECT prato.Nome
FROM prato
INNER JOIN receita ON receita.idPrato = prato.idPrato
INNER JOIN ingredientes ON ingredientes.idIngredientes = receita.idIngredientes
WHERE ingredientes.Nome = 'ovo';

-- Quais pratos utilizam farinha?
SELECT prato.Nome
FROM prato
INNER JOIN receita ON receita.idPrato = prato.idPrato
INNER JOIN ingredientes ON ingredientes.idIngredientes = receita.idIngredientes
WHERE ingredientes.Nome = 'farinha';
SELECT *
FROM consultafarinha;