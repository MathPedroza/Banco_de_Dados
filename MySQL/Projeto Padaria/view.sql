-- 1) Qual o Ingrediente que o cozinheiro “João” mais utiliza em suas receitas? 
-- Exiba: Nome_do_Cozinheiro | Ingrediente
CREATE VIEW ingredientejoao AS
SELECT cozinheiro.Nome AS 'Nome_do_Cozinheiro',  ingredientes.Nome AS 'Ingrediente', COUNT(*) AS quantidade
FROM ingredientes
INNER JOIN receita ON ingredientes.idIngredientes = receita.idIngredientes
INNER JOIN prato ON receita.idPrato = prato.idPrato
INNER JOIN cozinheiro ON prato.idCozinheiro = cozinheiro.idCozinheiro
WHERE cozinheiro.Nome = 'Joao'
GROUP BY ingredientes.idIngredientes
ORDER BY quantidade desc
LIMIT 1;

SELECT *
FROM ingredientejoao;

-- 2) Dos pratos que o “João” faz, qual o mais barato e com menos ingredientes?
-- Exiba:  Nome_do_Cozinheiro | Nome_do_Pratos | Preço_do_Prato | Qtde_Ingredientes
CREATE VIEW pratobarato AS 
SELECT cozinheiro.Nome AS 'Nome_do_Cozinheiro', prato.nome AS 'Nome_do_Prato', prato.Preco AS 'Preço_do_Prato', COUNT(ingredientes.Nome) AS 'Qtde_Ingredientes'
FROM ingredientes
INNER JOIN receita ON ingredientes.idIngredientes = receita.idIngredientes
INNER JOIN prato ON receita.idPrato = prato.idPrato
INNER JOIN cozinheiro ON prato.idCozinheiro = cozinheiro.idCozinheiro
WHERE cozinheiro.Nome = 'Joao' 
GROUP BY prato.idPrato
ORDER BY MIN(prato.Preco)
LIMIT 1;

SELECT *
FROM pratobarato;

-- 3) Crie uma pergunta (como essas acima) ou faça uma consulta que forneça uma
-- informação valiosa para tomada de decisão usando, logicamente, o conceito de Visão (VIEW).
-- Criei uma view que mostra quantos ingredientes cada prato possui.
CREATE VIEW qtdingredientesprato AS 
SELECT p.nome AS Nome_do_Prato , COUNT(*) AS  Qtde_de_Ingredientes
FROM prato p
INNER JOIN receita r
ON r.idPrato = p.idPrato
GROUP BY p.nome;

SELECT * 
FROM qtdingredientesprato;