# Relatórios SQL a serem desenvolvidos

## QUESTÃO 01: 
### prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
#### Ao utilizar o comando : "select avg(salario) from funcionario;" sera exibido a media salarial dos funcionarios que é de: 35125.00

## QUESTÃO 02: 
### prepare um relatório que mostre a média salarial dos homens e das mulheres.
#### Para conseguir ver a media salarial das funcionarias mulheres utilizamos o codigo "select (sum(salario)/count(*)) as media from funcionario where sexo = 'F';" e sera exibido a media salarial das mulheres. Agora para ver a media salarial dos homens basta apenas trocar a variável de valor 'F' para 'M' O comando ficará : "select (sum(salario)/count(*)) as media from funcionario where sexo = 'M';" e a média que será mostrada é de: 37.600,00.

## QUESTÃO 03: 
### prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes informações de seus funcionários: o nome completo, a data de nascimento, a idade em anos completos e o salário.
#### Para realizar uma projeção com todas essas informações, primeiro precisamos verificar se todos os campos que queremos exibir estão realmente criados no banco de dados. Continuando, ao verificar se todos eles existem, notamos que não há um campo específico, este campo seria a idade do funcionario, que precisamos criar essa coluna que não estava originalmente no projeto Elmasri, o comando para criar a coluna "idade" na tabela "funcionario" do projeto Elmasri e adicioná-la ao script ficara assim:
#### "CREATE TABLE funcionario ( cpf CHAR(11) NOT NULL, numero_departamento INT NOT NULL, cpf_supervisor CHAR(11) NOT NULL, primeiro_nome VARCHAR(15) NOT NULL, nome_meio CHAR(1), ultimo_nome VARCHAR(15) NOT NULL, data_nascimento DATE, endereco VARCHAR(40), idade INTEGER, <---- sexo CHAR(1), salario DECIMAL(10,2), PRIMARY KEY (cpf) );"

#### Feito isso, passando para a projeção das informações, devemos agora calcular a diferença de data entre hoje e a data de nascimento de cada funcionário registrado. Isso nos dará uma ideia aproximada da idade calculada do funcionário. Com isso, repetiremos os seguintes comandos para todos os funcionários:
#### "SELECT datediff ('2022-05-02','1965-01-09')/365 AS 'Idade_João';"

#### Este comando utiliza a propriedade 'datediff
#### Agora com todos esses numeros anotados vamos utilizar outro comando pois os numeros que o mariaDB nos entregou veio quebrado e precisamos de numeros inteiros o comando ficara assim:
#### "SELECT ceil(valor) FROM tabela WHERE <coluna_da_condição> = <valor_da_condição>;"
#### Ao adicionar nossas informações que conseguimos com o primeiro codigo o comando ficara assim:
#### "SELECT ceil(57.3479) FROM funcionario WHERE primeiro_nome = 'João';"
#### Onde 57.3479 é os anos que o comando DATEDIFF nos retornou, funcionario sendo a tabela e primeiro_nome a coluna onde a condição é que o primeiro nome é = a João
#### Isso retornará a idade em numeros inteiros que no caso de João é 58, após fazer esse comando para todos os funcionarios vamos atualizar os dados presentes na tabela para que fique mais facil exibir no final todos os dados, o comando que vamos utilizar vai ser: 
#### UPDATE funcionario SET idade = '58' WHERE primeiro_nome = 'João';
#### onde idade é o nome da coluna que vamos adicionar as idades de cada funcionario primeiro_nome a coluna que vamos correlacionar e a condição vai ser o nome do funcionario que vamos por a sua idade.
#### Por fim, só é necessário projetar as informações que o relatorio solicita, para isso vamos precisar juntar uma tabela a outra atraves do comando "INNER JOIN" o comando ficara assim:

#### "SELECT CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS "nome_completo", departamento.nome_departamento, funcionario.data_nascimento, funcionario.idade, funcionario.salario FROM departamento INNER JOIN funcionario ON departamento.numero_departamento = funcionario.numero_departamento;"
#### este comando fara com que nos retorne uma projeção das duas tabelas mostrando todas as informações necessárias.

## QUESTÃO 04: 
### prepare um relatório que mostre o nome completo dos funcionários, a idade em anos completos, o salário atual e o salário com um reajuste que obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a 35.000 o reajuste deve ser de 15%.
####



## QUESTÃO 05: 
### prepare um relatório que liste, para cada departamento, o nome do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente).

#### Para obter os resultados necessários, são necessárias várias seleções, incluindo seleções com características um pouco específicas, para que os valores não se repitam quando não precisam ser repetidos em diferentes partes da coluna. A primeira seleção de uma seleção é usado para filtrar quais gerentes estão, em qual Departamento trabalha e exibe essas informações em um INNER JOIN que especifique as restrições. Então a seleção ficara assim:

#### "SELECT * FROM (SELECT CONCAT("Gerente do departamento ", departamento.nome_departamento) AS nome_departamento, CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario FROM departamento INNER JOIN funcionario ON departamento.numero_departamento = funcionario.numero_departamento WHERE cpf_gerente = cpf ORDER BY nome_departamento asc) AS gerente"

#### Observe que a ordem de exibição também precisará ser especificada usando o comando ORDER BY no final deste código para atender às restrições de ordem exigidas pelo relatorio. Observe também que neste caso o comando WHERE limita os resultados encontrados se o cpf do gerente deve ser igual ao cpf do funcionário, permitindo que INNER JOIN aconteça sem duplicação de cpfs. No entanto, agora que selecionamos o que queremos desse comando SELECT, precisamos recuperar o resultado dele e adicioná-lo aos outros resultados da segunda seleção, que ainda não mostrei. Então, apenas colocamos um comando UNION entre eles que concatenará os dois resultados do comando SELECT: 

#### Agora, para completar a união, é necessária outra parte do resultado de outro SELECT, que é a segunda parte a ser digitada. Este SELECT tem a capacidade de agrupar as mesmas informações que foram agrupadas pelo primeiro SELECT, mas desta vez só precisa exibir cpfs que não são de propriedade do gerente, pois isso é feito pelo primeiro comando SELECT. Deste jeito o comando ficara assim:

#### "SELECT * FROM (SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario FROM departamento INNER JOIN funcionario ON departamento.numero_departamento=funcionario.numero_departamento WHERE NOT cpf_gerente = cpf ORDER BY salario desc) AS funcionario;"

#### Por fim, este SELECT também possui a funcionalidade ORDER BY, mas agora está configurado para classificar todos os salários na tabela de funcionários em ordem decrescente. Além disso, como a função desse SELECT é exibir todos os cpfs que não são de gerente, o comando WHERE retorna, mas desta vez na forma de WHERE NOT especificando que o SELECT aplica-se apenas nas tuplas em que coluna cpf_gerente é diferente da coluna cpf, da tabela de funcionários. Para resumir, basta juntar os dois comandos SELECT e colocar o comando UNION no meio entre eles para a união e projeção desejada, o comando ficara assim:

============================================================================================
#### "SELECT * FROM (SELECT CONCAT("Gerente do departamento ", departamento.nome_departamento) AS nome_departamento, CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario FROM departamento INNER JOIN funcionario ON departamento.numero_departamento = funcionario.numero_departamento WHERE cpf_gerente = cpf ORDER BY nome_departamento asc) AS gerente 
### UNION 
#### SELECT * FROM (SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ". ",funcionario.ultimo_nome) AS nome_completo_funcionario FROM departamento INNER JOIN funcionario ON departamento.numero_departamento=funcionario.numero_departamento WHERE NOT cpf_gerente = cpf ORDER BY salario desc) AS funcionario;"
============================================================================================

## QUESTÃO 06: 
### prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer como “Masculino” ou “Feminino”).






















## QUESTÃO 07: 
### prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.
## QUESTÃO 08: 
### prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.
## QUESTÃO 09: 
### prepare um relatório que mostre a soma total das horas de cada projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, o nome do projeto e a soma total das horas.
## QUESTÃO 10: 
### prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
## QUESTÃO 11: 
### considerando que o valor pago por hora trabalhada em um projeto é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.
## QUESTÃO 12: 
### seu chefe está verificando as horas trabalhadas pelos funcionários nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste o nome do departamento, o nome do projeto e o nome dos funcionários que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.
## QUESTÃO 13: 
### durante o natal deste ano a empresa irá presentear todos os funcionários e todos os dependentes (sim, a empresa vai dar um presente para cada funcionário e um presente para cada dependente de cada funcionário) e pediu para que você preparasse um relatório que listasse o nome completo das pessoas a serem presenteadas (funcionários e dependentes), o sexo e a idade em anos completos (para poder comprar um presente adequado). Esse relatório deve estar ordenado pela idade em anos completos, de forma decrescente.
## QUESTÃO 14: 
### prepare um relatório que exiba quantos funcionários cada departamento tem.
## QUESTÃO 15: 
### como um funcionário pode estar alocado em mais de um projeto, prepare um relatório que exiba o nome completo do funcionário, o departamento desse funcionário e o nome dos projetos em que cada funcionário está alocado. Atenção: se houver algum funcionário que não está alocado em nenhum projeto, o nome completo e o departamento também devem aparecer no relatório.
