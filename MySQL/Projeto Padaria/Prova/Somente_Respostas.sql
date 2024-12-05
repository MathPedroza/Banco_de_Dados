-- 1) Quem foi que comprou a pizza mais cara no dia 22/06/2011? Exiba o nome do cliente, da pizza e o preço dela. (1,0 ponto) 
SELECT c.nome, pd.nome, pd.preco
FROM cliente c
INNER JOIN pedido p
ON c.idcliente = p.idcliente
INNER JOIN pedidoitem 
ON p.idPedido = pedidoitem.idPedido
INNER JOIN produto pd
ON pedidoitem.idProduto = pd.idProduto
WHERE p.DataPedido = '2011-06-22' AND pd.idTipoProduto = '1'
ORDER BY pd.preco 
DESC LIMIT 1;

-- 2) Quem fez o maior pedido no dia que mais houve faturamento? (1,0 ponto) 
SELECT c.Nome AS "Nome_Cliente", p.PrecoTotal AS "Preco_Total"
FROM cliente c
INNER JOIN pedido p
ON p.idCliente = c.idCliente
WHERE p.DataPedido = (SELECT p.DataPedido FROM pedido p GROUP BY p.DataPedido ORDER BY SUM(p.PrecoTotal) DESC LIMIT 1)
ORDER BY p.PrecoTotal DESC LIMIT 1;