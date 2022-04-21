psql -U postgres -W

create user pedro with password '1303'

ALTER USER pedro createdb;


CREATE database uvv 
WITH
owner = pedro
encoding = 'UTF8'
template = template0
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE;

psql -U pedro uvv -W
	1303



	
CREATE SCHEMA IF NOT EXISTS elmasri 
	AUTHORIZATION pedro;

grant ALL PRIVILEGES ON ALL tables IN SCHEMA elmasri TO pedro;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
								SEGUNDA PARTE:
								
SET search_path TO elmasri, "$user", public;


CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(40),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);

insert into elmasri.funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) values (
     'João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP','M','30000', '33344555587', '5'),
     ('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M','40000','33344555587', '5'),
     ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', '25000', '98765432168', '4'),
     ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av.Arthur de Lima, 54, Santo André, SP', 'F', '43000', '98765432168', '4'),
     ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38000', '33344555587', '5'),
     ('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', '25000', '33344555587', '5'),
     ('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', '25000', '98765432168', '4'),
     ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', '55000', '88866555576', '1');



COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionario';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);

insert into elmasri.departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) values (
     'Pesquisa', '5', '33344555587', '1988-05-22'),
     ('Administração', '4', '98765432168', '1995-01-01'),
     ('Matriz', '1', '88866555576', '1981-06-19');


COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente depart. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);

insert into elmasri.projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) values (
     'ProdutoX', '1', 'Santo André', '5'),
     ('ProdutoY', '2', 'Itu', '5'),
     ('ProdutoZ', '3', 'São Paulo', '1'),
     ('Informação', '10', 'Mauá', '4'),
     ('Reorganização', '20', 'São Paulo', '1'),
     ('Novosbeneficios','30', 'Mauá', '4');


COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);

insert into elmasri.trabalha_em (cpf_funcionario, numero_projeto, horas) values (
     '12345678966', '1', '32.5'),
     ('12345678966', '2', '7.5'),
     ('66688444476', '3', '40'),
     ('45345345376', '1', '20'),
     ('45345345376', '2', '20'),
     ('33344555587', '2', '10'),
     ('33344555587', '3', '10'),
     ('33344555587', '10', '10'),
     ('33344555587', '20', '10'),
     ('99988777767', '30', '30'),
     ('99988777767', '10', '10'),
     ('98798798733', '10', '35'),
     ('98798798733', '30', '5'),
     ('98765432168', '30', '20'),
     ('98765432168', '20', '15'),
     ('88866555576', '20', '0');


COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'É uma PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'É uma PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);

insert into elmasri.localizacoes_departamento (numero_departamento, local) values (
     '1', 'São Paulo'),
     ('4', 'Mauá'),
     ('5', 'Santo André'),
     ('5', 'Itu'),
     ('5', 'São Paulo');


COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'É  uma PK desta tabela e uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);

insert into elmasri.dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) values (
     '33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
     ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
     ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
     ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
     ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
     ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'), 
     ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');


COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'É uma PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT sexo_m_f_dependente CHECK (sexo IN ('M','F')); 
ALTER TABLE elmasri.funcionario ADD CONSTRAINT sexo_m_f_funcionario CHECK (sexo IN ('M','F')); 
ALTER TABLE elmasri.funcionario ADD CONSTRAINT salario_funcionario CHECK (salario BETWEEN '2000' AND '100000');
ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT horas_trabalha_em CHECK (horas BETWEEN '0' AND '200'); 
ALTER TABLE elmasri.funcionario ADD CONSTRAINT numero_departamento_funcionario CHECK (numero_departamento BETWEEN '1' AND '15'); 
ALTER TABLE elmasri.departamento ADD CONSTRAINT numero_departamento_departamento CHECK (numero_departamento BETWEEN '1' AND '15'); 
ALTER TABLE elmasri.projeto ADD CONSTRAINT numero_departamento_projeto CHECK (numero_departamento BETWEEN '1' AND '15'); 
ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT numero_departamento_localicazoes_departamento CHECK (numero_departamento BETWEEN '1' AND '10');

