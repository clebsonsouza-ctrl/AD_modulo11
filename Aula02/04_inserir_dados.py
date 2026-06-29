import psycopg2
from config import DB_CONFIG

# conecta ao banco aula01
conexao = psycopg2.connect(
    host=DB_CONFIG["host"],
    database="aula02",
    user=DB_CONFIG["user"],
    password=DB_CONFIG["password"],
    port=DB_CONFIG["port"]
)

cursor = conexao.cursor()

query = """
INSERT INTO alunos (nome, idade, cidade)
VALUES
    ('Ana', 25, 'João Pessoa'),
    ('Carlos', '30', 'Recife');

"""

# insere duas linhas na tabela alunos
cursor.execute(query)

# confirma a inserção
conexao.commit()

print("Dados inseridos com sucesso.")

cursor.close()
conexao.close()

print("Conexão com o banco aula02 encerrada.")