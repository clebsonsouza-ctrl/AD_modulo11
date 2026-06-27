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

-- Contar quantidade de registros existentes na tabela "clientes"

SELECT count(*) FROM clientes;

-- Conta quantos status diferentes existem na tabela "status_vendas"

SELECT count(DISTINCT status) FROM status_vendas;

-- Somar todas as quantidades da coluna quantidade da tabela "vendas"

SELECT SUM(quantidade) FROM vendas;

-- Calcular a média da idade dos clientes da tabela "Cliente"

SELECT round(AVG(idade), 2) FROM clientes;

-- Retorna o menor e o maior preço cadastrados na tabela `produtos`.
SELECT MIN(preco), MAX(preco) FROM produtos;

-- FUNÇÕES DE TRATAMENTO

-- UPPER(tudo maiúsculo)
SELECT 
	produto AS produto_original,
	UPPER(produto) AS produto_maiusculo
FROM produtos;

-- LOWER(tudo minúsculo)
SELECT 
	produto AS produto_original,
	LOWER(produto) AS produto_minusculo
FROM produtos;

-- CONCAT (junta textos)

-- Concatenar o nome do produto, texto R$ e o preço em única coluna.

SELECT
	id,
	CONCAT(produto, ' - ', 'R$', preco) AS info_produto
FROM produtos;

-- COALESCE (tratar valores nulos)

SELECT 
	email,
	COALESCE(email, 'Sem Informação') AS email_tratado
FROM clientes;

-- REPLACE (substituir textos)

SELECT 
	*,
	REPLACE(produto, 'SSD 500GB', 'SSD 250GB') AS prod_corrigido
FROM produtos;

-- TRIM (remove espaços)
-- Mostra todos os dados dos produtos e cria uma coluna com o nome do produto sem espaços no início e no fim.
SELECT *,
 TRIM(produto) AS prod_tratado
 FROM produtos;

 -- SUBSTRING (extrair parte do texto) - EXTRAIR O ANO

-- Mostra todas as vendas e cria uma coluna com o ano extraído da data da venda.
SELECT *,
SUBSTRING(data_venda::TEXT,1,4) AS ano
FROM vendas;

-- SPLIT_PART (a partir de um caracter) - antes do arroba

-- Mostra o e-mail e extrai a parte antes do @, identificando o usuário do e-mail.
SELECT 
    email,
    SPLIT_PART(email, '@', 1) AS usuario
FROM clientes;

-- AGRUPAMENTOS
-- Conta quantos clientes existem em cada estado.

SELECT 
	estado,
	count(cliente) 
FROM clientes
GROUP BY estado;

-- Qual a média de idade dos meus clientes por estado?
SELECT 
	estado,
	round(AVG(idade),2) AS Media_idade
FROM clientes
GROUP BY estado
ORDER BY Media_idade DESC; 


-- WHERE E HAVING

-- FILTRAR ANTES DE AGRUPAR: WHERE
-- primeiro pega apenas clientes com idade maior ou igual a 30;
-- depois agrupa por estado
-- depois calcula a média de idade
-- depois ordena

SELECT 
	estado,
	round(AVG(idade), 2) AS media_idade
FROM clientes
WHERE idade >= 30
GROUP BY estado
ORDER BY media_idade DESC;

-- FILTRAR DEPOIS DE AGRUPAR: HAVING

-- primeiro agrupa os clientes por estado
-- depois calcula a média de idade de cada estado;
-- depois mostra apenas os estados cuja média é maior ou igual a 30.

SELECT 
    estado, 
    AVG(idade) AS media_idade
FROM clientes
GROUP BY estado
HAVING AVG(idade) >= 30
ORDER BY media_idade DESC;

-- RELACIONAR TABELAS -- 

-- LEFT JOIN: traz todos os registros da tabela da esquerda, mesmo sem correspondência na da direita.
-- Todos os clientes aparecem no resultado;
-- se um cliente tiver várias vendas, ele será repetido uma vez para cada venda.
-- obs.: Bruno Lima aparece nulo.
SELECT 
	clientes.cliente,
    vendas.quantidade    
FROM clientes
LEFT JOIN vendas ON clientes.id = vendas.cliente_id; 

SELECT * FROM clientes;
SELECT * FROM vendas;

-- RIGHT JOIN: traz todos os registros da tabela da direita, mesmo sem correspondência na da esquerda
SELECT 
	clientes.cliente,
    vendas.quantidade    
FROM clientes
RIGHT JOIN vendas ON clientes.id = vendas.cliente_id;

-- INNER JOIN: traz apenas os registros que existem nas duas tabelas
-- obs.: Bruno Lima não apareceu.
SELECT 
	clientes.cliente,
    vendas.quantidade    
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id;

-- vamos acrescentar mais uma relação com a tabela produtos (2 RELAÇOES E 3 TABELAS)
SELECT 
    clientes.cliente,
    vendas.quantidade,
    produtos.produto
FROM clientes
LEFT JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON vendas.produto_id = produtos.id;

-- INNER JOIN “quebra” o efeito de preservação do LEFT JOIN
SELECT 
    clientes.cliente,
    vendas.quantidade,
    produtos.produto
FROM clientes
LEFT JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON vendas.produto_id = produtos.id;

-- 3 RELAÇOES E 4 TABELAS
SELECT 
    clientes.cliente,
    vendas.data_venda,
    vendas.quantidade,
    produtos.produto,
    status_vendas.status
FROM clientes
LEFT JOIN vendas ON clientes.id = vendas.cliente_id
LEFT JOIN produtos ON vendas.produto_id = produtos.id
LEFT JOIN status_vendas ON vendas.id = status_vendas.venda_id;

/*
1. FROM
2. 1º JOIN
3. 2º JOIN
4. WHERE
5. GROUP BY
6. Funções agregadoras: SUM(), AVG(), COUNT(), MIN(), MAX()
7. HAVING
8. SELECT
9. ORDER BY
*/

SELECT -- (8)
    c.cliente, -- 'c' é o apelido da tabela 'clientes'
    c.cidade, 
    c.estado,
    SUM(v.quantidade * p.preco) AS total_vendido -- (6)
FROM clientes c -- (1)   -- aqui 'c' foi definido 
INNER JOIN vendas v ON c.id = v.cliente_id -- (2)
INNER JOIN produtos p ON p.id = v.produto_id -- (3)
WHERE v.data_venda >= '2026-01-01' -- (4)
GROUP BY c.cliente, c.cidade, c.estado -- (5)
HAVING SUM(v.quantidade * p.preco) > 2000 -- (7)
ORDER BY total_vendido DESC; -- (9)

-- VIEW -- 
-- é como uma “consulta salva” no banco de dados.

--Sem VIEW, a consulta ficaria assim:


SELECT
    c.cliente,
    c.cidade,
    c.estado,
    v.data_venda,
    TRIM(p.produto) AS produto,
    v.quantidade,
    p.preco,
    v.quantidade * p.preco AS valor_venda
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
INNER JOIN produtos p ON p.id = v.produto_id;

-- COM A VIEW

CREATE VIEW vw_resumo_vendas AS
SELECT
    c.cliente,
    c.cidade,
    c.estado,
    v.data_venda,
    TRIM(p.produto) AS produto,
    v.quantidade,
    p.preco,
    v.quantidade * p.preco AS valor_venda
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id
INNER JOIN produtos p ON p.id = v.produto_id;

-- Consultando a VIEW

SELECT * FROM vw_resumo_vendas;