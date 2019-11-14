import mysql.connector 

conn = mysql.connector.connect(
    host = '{{ ansible_default_ipv4.address }}',
    user = 'root',
    password = '{{ root_db_pass }}',
    database = 'twitter_app'
)

cur = conn.cursor()
cur.execute("create table if not exists twitts(id int auto_increment primary key, usuario varchar(255), mensagem longtext)")

params = ("test_user", "mensagem gerada durante o deploy para testes")
sql = "insert into twitts values(0, %s, %s)"
cur.execute(sql, params)
conn.commit()
