# Script do MariaDB

### No que se refere a criação do banco de dados no mariaDB vamos utilizar do script *__scriptmariadb.sql__* dentro da pasta pset1 e seguir o passo a passo asseguir.

1. Dentro de sua maquina virtual abra o terminal e logue no root do mariaDB com o comando "mysql -u root -p" e a senha "computacao@raiz"
2. Logo insira o comando para criar o usuario "CREATE USER 'pedro'@localhost IDENTIFIED BY '1303' ;"
3. Em seguida vamos dar todos os direito ao usuario com o comando "GRANT ALL PRIVILEGES ON *.* TO pedro@localhost;"

### A parte de criação do usuario esta pronta agora vamos entrar no user e criar o banco de dados

4. Para entrar em outro usuario vamos dar "exit" e logar agora com o usuario criado "mysql -u pedro  -p" e colocar a senha "1303"
5. Agora para criar o banco de dados vamos usar o seguinte comando "CREATE DATABASE IF NOT EXISTS uvv;"
6. agora vamos usar ele com o comando "USE uvv;"
7. agora ja estamos dentro do banco de dados criado pelo seu usuario apenas vamos copiar e colocar a segunda parte do script dentro do "*__scriptmariadb.sql__*"
8. assim o seu banco de dados estara criado e suas tabelas estaram com as devidas informações.

# Script do Postgres

### Agora no que se refere a criação do banco de dados no PostgresSQL vamos utilizar do *__scriptpostgre.sql__* dentro da pasta pset1 e seguir o passo a passo asseguir.

1. Dentro de sua maquina virtual abra o terminal e logue no postgres com o comando "psql -U postgres -W" e a senha "computacao@raiz"
2. Logo insira o comando para criar o usuario "create user pedro with password '1303'"
3. Em seguida vamos dar o direito de criar banco de dados ao usuario com o comando "ALTER USER pedro createdb;"
4. agora vamos criar o banco de dados sendo o dono o usuario que criamos com o seguinte comando:
5. "CREATE database uvv WITH owner = pedro encoding = 'UTF8' template = template0 LC_COLLATE = 'pt_BR.UTF-8' LC_CTYPE = 'pt_BR.UTF-8' ALLOW_CONNECTIONS = TRUE;"
6. Agora para entrar em outro usuario vamos dar "exit" e logar agora com o usuario criado no nosso banco de dados com o comando "psql -U pedro uvv -W"
7. agora vamos criar o schema elmasri para organizar o nosso banco de dados com o comando "CREATE SCHEMA IF NOT EXISTS elmasri 
	AUTHORIZATION pedro;"
8. agora vamos dar todos os privilegios para o nosso usuario dentro do schema com o comando "grant ALL PRIVILEGES ON ALL tables IN SCHEMA elmasri TO pedro;"
9. agora ja estamos dentro do banco de dados criado pelo seu usuario apenas vamos copiar e colocar a segunda parte do script dentro do "__scriptpostgre.sql__"
10. assim o seu banco de dados estara criado e suas tabelas estaram com as devidas informações.
