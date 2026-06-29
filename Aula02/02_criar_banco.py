import psycopg2
from config import DB_CONFIG

# conecta ao banco padrão postgres
conexao = psycopg2.connect(
    host=DB_CONFIG["host"],
    database=DB_CONFIG["database"],
    user=DB_CONFIG["user"],
    password=DB_CONFIG["password"],
    port=DB_CONFIG["port"]
)
# necessário para executar a cariação do banco (CREATE DATABASE)
conexao.autocommit = True

cursor = conexao.cursor()

# verifica se o banco aula02 já existe
cursor.execute("SELECT 1 FROM pg_database WHERE datname = 'aula02';") #executa uma consulta SQL no PostgreSQL (Existe algum banco de dados chamado aula02?)
banco_existe = cursor.fetchone()

if banco_existe:
    print("O aula02 já existe.")
else:
    cursor.execute("CREATE DATABASE aula02;")
    print("Banco aula02 criado com sucesso.")

cursor.close()
conexao.close()

print("Conexão com o banco aula02 postgres encerrada.")