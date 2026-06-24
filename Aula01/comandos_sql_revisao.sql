-- Revisão SQL --
-- aspas simples são usadas para valores de texto.
-- comparação de texto é sensível a letras maiúsculas e minúsculas.

-- COMANDOS DE SELEÇÃO --

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM status_vendas;

-- Selecionar os 5 primeiros registro

SELECT * FROM status_vendas
LIMIT 5;

-- Selecionar apenas os diferentes tipos de status

SELECT DISTINCT status FROM status_vendas;

-- renomear colunas e trazer apenas duas determinadas colunas

SELECT 
	cliente AS Clientes,
	cidade AS Municipios
FROM clientes;

-- COMANDOS ORDENAÇÃO --

SELECT 
* 
FROM vendas
ORDER BY data_venda DESC;

 -- COMANDOS DE FILTRAGENS --

 -- selecionar os clientes do estado SC

 SELECT * FROM clientes
 WHERE estado = 'SC';

-- selecionar os clientes do estado SC com idade menor do que 30 anos

SELECT * FROM clientes
 WHERE estado = 'SC' AND idade <= 30;

-- selecionar os clientes de SC e SP

SELECT * FROM clientes
 WHERE estado = 'SC' OR estado = 'SP';

-- Selecionar 3 ou mais estados

SELECT * FROM clientes
WHERE estado IN ('SP', 'SC', 'PE');

-- Selecionar uma faixa etária de clientes

SELECT * 
FROM clientes
WHERE idade BETWEEN 30 AND 50;

-- Selecionar cliente e o email cujo o email contém 'gmail'.
SELECT
	cliente,
	email
FROM clientes
WHERE email LIKE '%gmail%';

-- dois tipos de mail
SELECT
	cliente,
	email
FROM clientes
WHERE email LIKE '%gmail%' OR email LIKE '%outlook%';

-- Selecionar apenas os clientes cuja a idade começa com 2;

SELECT 
	cliente,
	email,
	idade
FROM clientes
WHERE idade::TEXT LIKE '2%'; -- começa com 2

-- Selecionar apenas os clientes cuja a idade termina com 2;

SELECT 
	cliente,
	email,
	idade
FROM clientes
WHERE idade::TEXT LIKE '%2'; -- termina com 2

-- Selecionar todos os clientes que não possuem email cadastrado.

SELECT * 
FROM clientes
WHERE email IS NULL;

-- FUNÇÕES MATEMÁTICAS -- 


