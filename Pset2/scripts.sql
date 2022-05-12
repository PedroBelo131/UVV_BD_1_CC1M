-- Questão 1
 select avg(salario) from funcionario;
 
-- Questão 2
select (sum(salario)/count()) as media_feminina from funcionario where sexo = 'F';
select (sum(salario)/count()) as media_masculina from funcionario where sexo = 'M';

-- Questão 3
SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS "nome_completo",
departamento.nome_departamento, funcionario.data_nascimento, funcionario.idade, funcionario.salario 
FROM departamento 
INNER JOIN funcionario 
ON departamento.numero_departamento = funcionario.numero_departamento;

-- Questão 4
ALTER TABLE funcionario ADD COLUMN salario_reajustado decimal(10,2);

UPDATE funcionario SET salario_reajustado= CASE WHEN salario < 35000 THEN salario * 1.20 WHEN salario >= 35000 THEN salario * 1.15 END;

SELECT CONCAT(primeiro_nome, " ", nome_meio, " ", ultimo_nome) AS "nome_completo", idade, salario, salario_reajustado FROM funcionario;

-- Questão 5
SELECT * 
FROM (SELECT CONCAT("Gerente do departamento ", departamento.nome_departamento) AS nome_departamento, 
CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario 
FROM departamento 
INNER JOIN funcionario 
ON departamento.numero_departamento = funcionario.numero_departamento 
WHERE cpf_gerente = cpf ORDER BY nome_departamento asc) AS gerente
UNION
SELECT * 
FROM (SELECT departamento.nome_departamento, 
CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario 
FROM departamento 
INNER JOIN funcionario 
ON departamento.numero_departamento=funcionario.numero_departamento 
WHERE NOT cpf_gerente = cpf ORDER BY salario desc) AS funcionario;

-- Questão 6
SELECT departamento.nome_departamento, 
CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_funcionario, 
CONCAT(dependente.nome_dependente, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_dependente, 
year(curdate()) - year(dependente.data_nascimento) AS idade_dependente, 
CASE dependente.sexo WHEN 'M' THEN 'Masculino' WHEN 'F' THEN 'Feminino' 
END AS sexo_dependente 
FROM dependente 
LEFT JOIN funcionario 
ON (dependente.cpf_funcionario=funcionario.cpf) 
INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento);

-- Questão 7
SELECT departamento.nome_departamento, 
CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS nome_completo_funcionario, 
funcionario.salario 
FROM funcionario 
LEFT JOIN dependente 
ON funcionario.cpf = dependente.cpf_funcionario 
INNER JOIN departamento 
ON funcionario.numero_departamento = departamento.numero_departamento 
WHERE dependente.cpf_funcionario IS null;

-- Questão 8
SELECT CONCAT("Departamento ", departamento.numero_departamento, " ", departamento.nome_departamento) AS departamento_e_nome, 
projeto.nome_projeto, 
CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS nome_completo_funcionario, 
trabalha_em.horas 
FROM funcionario 
INNER JOIN departamento 
ON funcionario.numero_departamento = departamento.numero_departamento 
INNER JOIN projeto AS p 
ON departamento.numero_departamento = p.numero_departamento 
INNER JOIN trabalha_em 
ON funcionario.cpf = trabalha_em.cpf_funcionario 
INNER JOIN projeto 
ON trabalha_em.numero_projeto = projeto.numero_projeto 
WHERE funcionario.numero_departamento = projeto.numero_departamento 
GROUP BY departamento_e_nome, nome_projeto, nome_completo_funcionario, horas;

-- Questão 9
SELECT DISTINCT departamento.nome_departamento, projeto.nome_projeto, sum(trabalha_em.horas) AS soma_das_horas 
FROM (departamento, projeto, trabalha_em) 
INNER JOIN departamento AS d 
ON (projeto.numero_departamento = d.numero_departamento) 
INNER JOIN trabalha_em AS tb 
ON (projeto.numero_projeto = tb.numero_projeto) 
GROUP BY nome_projeto, nome_departamento;

-- Questão 10
select avg(salario) from funcionario;

-- Questão 11
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo_funcionario, 
projeto.nome_projeto, trabalha_em.horas, sum(trabalha_em.horas)*0.50 as recebimento_horas 
from (funcionario, projeto, trabalha_em) 
inner join departamento as d 
on (projeto.numero_departamento = d.numero_departamento) 
inner join trabalha_em as tb 
on (projeto.numero_projeto = tb.numero_projeto) 
where funcionario.cpf = trabalha_em.cpf_funcionario 
group by nome_completo_funcionario, nome_projeto, nome_departamento, horas;

-- Questão 12
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo, 
departamento.nome_departamento, projeto.nome_projeto 
from (funcionario, departamento, projeto) 
inner join funcionario as f 
on (departamento.cpf_gerente = f.cpf) 
inner join projeto as p 
on (departamento.numero_departamento = p.numero_departamento) 
inner join trabalha_em as tb 
on (p.numero_projeto = tb.numero_projeto) 
where tb.horas = 0.0 and funcionario.cpf = tb.cpf_funcionario 
group by projeto.nome_projeto, departamento.nome_departamento, nome_completo;

-- Questão 13
select concat(f.primeiro_nome, " ", f.nome_meio, " ", f.ultimo_nome) as nome_completo_funcionario, 
concat(d.nome_dependente, " ", f.nome_meio, " ", f.ultimo_nome) as nome_completo_dependente, 
case f.sexo when f.sexo = "M" then "Masculino" when f.sexo = "F" then "Feminino" end as sexo_funcionario, 
case d.sexo when d.sexo = "M" then "Masculino" when d.sexo = "F" then "Feminino" end as sexo_dependente, 
concat(f.idade, " anos") as idade_funcionario, concat(year(curdate())-year(d.data_nascimento)," anos") as idade_dependente 
from (funcionario AS f, dependente, departamento AS dp) 
inner join dependente as d 
on (f.cpf = d.cpf_funcionario AND dp.numero_departamento = f.numero_departamento) 
group by nome_completo_funcionario, nome_completo_dependente, idade_funcionario, idade_dependente 
order by idade_funcionario desc, idade_dependente desc;

-- Questão 14
select concat("Departamento ", departamento.numero_departamento, " ", departamento.nome_departamento) as departamento, 
count(funcionario.cpf) as numero_de_funcionarios 
from (departamento, funcionario) 
inner join funcionario as f 
on (departamento.numero_departamento = f.numero_departamento) 
where funcionario.cpf = departamento.cpf_gerente 
group by departamento.numero_departamento;

-- Questão 15
SELECT DISTINCT CONCAT(f.primeiro_nome, " ", f.nome_meio, " ", f.ultimo_nome) AS "Nomes_completos:",
dpt.nome_departamento AS "Departamentos:", p.nome_projeto AS "Projetos:"
from departamento AS dpt
inner join projeto AS p 
inner join trabalha_em AS tb 
inner join funcionario AS f 
where dpt.numero_departamento = f.numero_departamento 
and p.numero_projeto = tb.numero_projeto 
and tb.cpf_funcionario = f.cpf
order by p.nome_projeto desc;
