#pip install psycopg2-binary

import psycopg2
from config import DB_CONFIG

# cria conexão com o banco padrão postgres
conexao = psycopg2.connect(
    host=DB_CONFIG["host"],
    database=DB_CONFIG["database"],
    user=DB_CONFIG["user"],
    password=DB_CONFIG["password"],
    port=DB_CONFIG["port"]
)

#O cursor é quem envia os comandos SQL e recebe os resultados.
cursor = conexao.cursor()

# cria a query de versão do postgre
query = """
SELECT version();
"""

# executa consulta para verificar a versão do PostgreSQL
cursor.execute(query)

# pega o resultado. versao do postgre
resultado = cursor.fetchone()

print("Conexão realizada com sucesso.")
print("Versão do PostgreSQL:")
print(resultado)

# fecha cursor e conexão
cursor.close()
conexao.close()

print("Conexão encerrada.")