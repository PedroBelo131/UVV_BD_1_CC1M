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
#### "CREATE TABLE funcionario ( cpf CHAR(11) NOT NULL, numero_departamento INT NOT NULL, cpf_supervisor CHAR(11) NOT NULL, primeiro_nome VARCHAR(15) NOT NULL, nome_meio CHAR(1), ultimo_nome VARCHAR(15) NOT NULL, data_nascimento DATE, endereco VARCHAR(40), idade INTEGER , sexo CHAR(1), salario DECIMAL(10,2), PRIMARY KEY (cpf) );"

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

#### Antes de tudo para exibirmos o reajuste de salario junto com as outras informações vamos precisar criar a coluna reajuste de salário dentro da tabela funcionario para guardar os dados dos reajustes salariais. Para isso vamos usar o comando de "ALTER TABLE" para adicionar a coluna "salario_reajustado" a tabela funcionario, o comando ficarra assim:
#### "ALTER TABLE funcionario ADD COLUMN salario_reajustado decimal(10,2);"
#### é importante ver que os dados como decimal devem ser iguais aos da coluna salario para que não ocorra erro na hora da projeção.

#### Continuando, agora precisamos inserir o conteúdo dos dados nesta nova coluna para registrar o novo valor salarial reajustado. Como criamos a coluna 'salario_reajustado', mas nenhum dado foi inserido, todas as tuplas são NULL. Para inserir dados em tuplas NULL, usaremos comandos básicos de manipulação de dados do MySQL. A função que utilizaremos no nosso comando é UPDATE e realiza uma atualização no valor da coluna criada na tabela fornecida, além de usar o comando para inserir novos valores na coluna 'salario_reajustado', usaremos operadores SQL para verificar o valor do salário e seguir nossas instruções para decidir por qual salário multiplicar. Este operador chama-se CASE e iremos utilizar o comando da seguinte forma:

#### "UPDATE funcionario SET salario_reajustado= CASE WHEN salario < 35000 THEN salario * 1.20 WHEN salario >= 35000 THEN salario * 1.15 END;"

#### O funcionamento da função "CASE" é determinado pelas condições nela especificadas. Nesse caso, a condição é representada pela função "WHEN" que significa que quando algo acontecer é para acontecer outra coisa. Com essa estrutura de código, informamos ao comando UPDATE para atualizar a coluna 'salario_reajustado' quando o valor do salário for menor que 35000, preencha a coluna com o resultado da operação matemática de aumento de 20%, e quando for maior ou igual para 35.000, com um aumento de apenas 15% no preenchimento da coluna. Por fim, agora só precisamos usar o comando SELECT para exibir as informações que queremos, usando CONCAT para unir primeiro_nome, nome_meio, ultimo_nome para forma uma coluna só "nome_completo" o comando ficara assim:

#### SELECT CONCAT(primeiro_nome, " ", nome_meio, " ", ultimo_nome) AS "nome_completo", idade, salario, salario_reajustado FROM funcionario;
#### Assim eexibindo todas as informações requeridas no relatório.


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

#### Primeiro, precisamos selecionar todas as colunas para especificar a tabela na qual precisamos exibir as informações. Portanto, esta seleção pode ser feita usando o comando SELECT que aparece principalmente no vocabulário MySQL. No entanto, você também deve escolher uma chave comum para identificar os dois conjuntos, pois ambas as seleções usam dados de várias tabelas. Assim, após listar todas as colunas que queremos exibir junto ao comando SELECT, é necessário vinculá-las com uma chave comum para que as informações apareçam juntas no display.

#### Geralmente, quando realmente queremos unir tabelas ou funções SELECT entre si, usamos o comando UNION, mas haverá informações duplicadas, e o comando UNION nos limita a ter que selecionar o mesmo número de tabelas para que possamos prosseguir com a união. No entanto, o mesmo resultado pode ser obtido usando a função JOIN do MySQL, neste caso, para vincular as tabelas com sua chave comum, usamos INNER JOIN e LEFT JOIN para que determinem quais tabelas não precisam ser exibidas no momento da exibição, mas que precisam estar ali para conectar as informações de uma tabelas a outra.

#### Infelizmente, não há muito para detalhar este código, pois é uma junção de JOIN's com um comando SELECT e suas colunas selecionadas. No entanto, é possivel mostrar o formato das estruturas, o comando ficara desta forma:

#### "SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_funcionario, CONCAT(dependente.nome_dependente, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_dependente, year(curdate()) - year(dependente.data_nascimento) AS idade_dependente, CASE dependente.sexo WHEN 'M' THEN 'Masculino' WHEN 'F' THEN 'Feminino' END AS sexo_dependente FROM dependente LEFT JOIN funcionario ON (dependente.cpf_funcionario=funcionario.cpf) INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento);"


## QUESTÃO 07: X
### prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.

#### "select departamento.nome_departamento, concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo_funcionario, funcionario.salario from funcionario -> left join dependente on funcionario.cpf = dependente.cpf_funcionario -> inner join departamento on funcionario.numero_departamento = departamento.numero_departamento -> where dependente.cpf_funcionario is null;"





## QUESTÃO 08: X
### prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.


#### "select * from
(select da sum(de um select que tenha apenas o número de horas trabalhadas por cada funcionario))


select concat("Departamento ", departamento.numero_departamento, " ", departamento.nome_departamento) as departamento_e_nome, projeto.nome_projeto, concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo_funcionario, trabalha_em.horas from funcionario
-> inner join departamento on funcionario.numero_departamento = departamento.numero_departamento
-> inner join projeto as p on departamento.numero_departamento = p.numero_departamento
-> inner join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario
-> inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto
-> where funcionario.numero_departamento = projeto.numero_departamento; ---> código que dá 22 rows, com repetidas."




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
