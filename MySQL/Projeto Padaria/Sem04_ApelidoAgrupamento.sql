-- 1) Qual a quantidade de pratos por cozinheiro? Ou qual a quantidade de pratos que cada cozinheiro faz?
-- Exiba: Nome_do_Cozinheiro | Qtde_de_Pratos
SELECT cozinheiro.nome AS Nome_do_Cozinheiro, COUNT(*) AS  Qtde_de_Pratos
FROM prato
INNER JOIN cozinheiro 
ON cozinheiro.idCozinheiro = prato.idCozinheiro
GROUP BY cozinheiro.nome;

-- 2) Qual a quantidade de Ingredientes por prato? Ou qual a quantidade de ingredientes que cada prato utiliza?
-- Exiba: Nome_do_Prato | Qtde
SELECT p.nome AS Nome_do_Prato , COUNT(*) AS  Qtde_de_Ingredientes
FROM prato p
INNER JOIN receita r
ON r.idPrato = p.idPrato
GROUP BY p.nome;

-- 3) Qual a quantidade de pratos que utilizam cada ingrediente? Ou qual a quantidade de pratos que cada ingrediente está sendo utilizado?
-- Exiba: Nome_do_Ingrediente | Qtde_de_Pratos_Utilizam_Ingrediente
SELECT i.Nome AS Nome_do_Ingrediente, COUNT(*) AS Qtde_de_Pratos_Utilizam_Ingrediente
FROM prato p
INNER JOIN receita r
ON p.idPrato = r.idPrato
INNER JOIN ingredientes i
ON i.idIngredientes = r.idIngredientes
GROUP BY r.idIngredientes;
