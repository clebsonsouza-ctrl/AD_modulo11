-- clientes
CREATE TABLE clientes (
  id          INT PRIMARY KEY, -- o id não pode se repetir, não pode ser Null
  cliente     VARCHAR(100),
  email       VARCHAR(255) NULL,
  cidade      VARCHAR(100),
  estado	  VARCHAR(2),
  idade       INT
);

-- produtos
CREATE TABLE produtos (
  id          INT PRIMARY KEY,
  produto     VARCHAR(100),
  preco       DECIMAL(10,2)  -- armazenará números decimais, 10 dígitos e 2 casas decimais
);

-- vendas
CREATE TABLE vendas (
  id          INT PRIMARY KEY,
  data_venda DATE,
  cliente_id INT REFERENCES clientes(id), -- esse valor deve corresponder a um id existente na tabela clientes
  produto_id  INT REFERENCES produtos(id),
  quantidade  INT
);

-- status vendas
CREATE TABLE status_vendas (  
  venda_id  INT REFERENCES vendas(id), -- esse valor deve corresponder a um id existente na tabela clientes 
  data_status DATE,  
  status VARCHAR(20)  
);


-- inserir clientes
INSERT INTO clientes (id, cliente, email, cidade, estado, idade) VALUES
(1, 'Joao Gomes', 'joao@gmail.com', 'Recife', 'PE', 32),
(2, 'Bruno Lima', 'bruno@yahoo.com', 'Caruaru','PE', 29),
(3, 'Daniel Oliveira', 'daniel@yahoo.com', 'Belo Horizonte','MG', 35),
(4, 'Dona Flor', 'donaflor@gmail.com', 'Florianópolis', 'SC', 42),
(5, 'Odorico Bezerra', 'odorico@outlook.com', 'Uberlândia', 'MG', 58),
(6, 'Gabriela Santos', 'gabriela@outlook.com', 'Joinville', 'SC', 27),
(7, 'Ana Souza',NULL ,'Blumenau','SC', 40),
(8, 'Nazaré Tedesco', 'nazare@outlook.com', 'Campinas', 'SP', 64),
(9, 'Elisa Rocha', 'elisa@yahoo.com', 'João Pessoa','PB', 21),
(10, 'Carla Fernandes', 'carla@outlook.com', 'São Paulo','SP', 19)
;

-- inserir produtos
INSERT INTO produtos (id, produto, preco) VALUES
(101, '    Fone Bluetooth',       149.90),
(102, 'Teclado Mecânico',     299.00),
(103, 'Mouse Gamer    ',          129.50),
(104, 'Monitor 24” FHD',      799.00),
(105, 'Cadeira Gamer',       1199.00),
(106, '   Webcam HD   ',            199.90),
(107, 'Headset USB',          249.90),
(108, 'SSD 500GB',            349.00);


-- inserir vendas
INSERT INTO vendas (id, data_venda, cliente_id, produto_id, quantidade) VALUES
(1,  '2025-11-01', 1, 101, 4),
(3,  '2025-12-02', 3, 102, 6),
(4,  '2025-12-02', 4, 104, 2),
(5,  '2025-12-03', 5, 105, 5),
(7,  '2026-01-04', 7, 107, 3),
(8,  '2026-01-04', 8, 108, 2),
(9,  '2026-01-05', 9, 101, 1),
(10, '2026-02-05', 10, 104, 3),
(11, '2026-02-06', 3, 105, 10),
(12, '2026-03-06', 1, 102, 5),
(13, '2026-03-07', 6, 108, 5),
(14, '2026-03-07', 8, 101, 9),
(15, '2026-03-08', 8, 107, 7);

-- inserir status_vendas
INSERT INTO status_vendas (venda_id, data_status, status) VALUES
(1, '2025-11-03', 'ENTREGUE'),
(3, '2025-12-05', 'ENVIADO'),
(4, '2025-12-06', 'PENDENTE'),
(5, '2025-12-07', 'CANCELADO'),
(7, '2026-01-06', 'ENVIADO'),
(8, '2026-01-07', 'PENDENTE'),
(9, '2026-01-08', 'ENTREGUE'),
(10, '2026-02-09', 'CANCELADO'),
(11, '2026-02-08', 'ENVIADO'),
(12, '2026-03-09', 'ENTREGUE'),
(13, '2026-03-10', 'PENDENTE'),
(14, '2026-03-10', 'ENVIADO'),
(15, '2026-03-11', 'ENTREGUE');