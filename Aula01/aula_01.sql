-- CRIAR TABELA EXEMPLOS TEXTO

CREATE TABLE exemplo_textos(
id SERIAL PRIMARY KEY,
sigla_estado CHAR(2),
nome_cliente VARCHAR(100),
obervacao TEXT,
cliente_ativo BOOLEAN
);

INSERT INTO exemplo_textos(
sigla_estado, nome_cliente, obervacao, cliente_ativo
)
VALUES(
'SP', 'Paulo Renan', 'entregar apenas pela manhã', FALSE
);

SELECT * FROM exemplo_textos;

-- CRIAR TABELA EXEMPLOS NUMEROS

CREATE TABLE exemplo_numero (

id SERIAL PRIMARY KEY,
produto VARCHAR(100),
quantidade INT,
preco DECIMAL(10,2),
peso_kg DOUBLE PRECISION
);

INSERT INTO exemplo_numero(
produto, quantidade, preco, peso_kg
)
VALUES(
'Notebook', 2, 3500.90, 1.85
);

SELECT * FROM exemplo_numero;

-- CRIAR TABELA EXEMPLO DATAS

CREATE TABLE exemplo_data(
criacao_em TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
descricao TEXT,
data_evento DATE,
data_hora_sem_fuso TIMESTAMP WITHOUT TIME ZONE 
);

INSERT INTO exemplo_data(
descricao, data_evento, data_hora_sem_fuso
)
VALUES(
'Aula 02', '2026-06-22', '2026-06-22 15:30:00'
);

SELECT * FROM exemplo_data;

SELECT current_setting('TimeZone');

SET TIME ZONE 'America/Sao_Paulo';

SELECT * FROM exemplo_data;
