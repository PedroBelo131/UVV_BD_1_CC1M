# Relatórios SQL a serem desenvolvidos

## QUESTÃO 01: 
### prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
#### Ao utilizar o comando : "select avg(salario) from funcionario;" sera exibido a media salarial dos funcionarios que é de: 35125.00

#### Tabela a ser exibida:
| avg(salario) |
|--------------|
| 35125.000000 |


## QUESTÃO 02: 
### prepare um relatório que mostre a média salarial dos homens e das mulheres.
#### Para conseguir ver a media salarial das funcionarias mulheres utilizamos o codigo "select (sum(salario)/count(*)) as media_feminina from funcionario where sexo = 'F';" e sera exibido a media salarial das mulheres. Agora para ver a media salarial dos homens basta apenas trocar a variável de valor 'F' para 'M' O comando ficará : "select (sum(salario)/count(*)) as media_masculina from funcionario where sexo = 'M';" e a média que será mostrada é de: 37.600,00.

#### Tabela feminina
| media_feminina |
|----------------|
|   31000.000000 |

#### Tabela masculina

| media_masculina |
|-----------------|
|    37600.000000 |



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
#### A tabela ficara assim:


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

#### A tabela retornara assim:

| nome_departamento                       | nome_completo_funcionario |
|-----------------------------------------|---------------------------|
| Gerente do departamento Matriz          | Jorge E. Brito            |
| Gerente do departamento Administração   | Jennifer S. Souza         |
| Gerente do departamento Pesquisa        | Fernando T. Wong          |
| Pesquisa                                | João B. Silva             |
| Pesquisa                                | Joice A. Leite            |
| Pesquisa                                | Ronaldo K. Lima           |
| Administração                           | André V. Pereira          |
| Administração                           | Alice J. Zelaya           |



## QUESTÃO 06:
### prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer como “Masculino” ou “Feminino”).

#### Primeiro, precisamos selecionar todas as colunas para especificar a tabela na qual precisamos exibir as informações. Portanto, esta seleção pode ser feita usando o comando SELECT que aparece principalmente no vocabulário MySQL. No entanto, você também deve escolher uma chave comum para identificar os dois conjuntos, pois ambas as seleções usam dados de várias tabelas. Assim, após listar todas as colunas que queremos exibir junto ao comando SELECT, é necessário vinculá-las com uma chave comum para que as informações apareçam juntas no display.

#### Geralmente, quando realmente queremos unir tabelas ou funções SELECT entre si, usamos o comando UNION, mas haverá informações duplicadas, e o comando UNION nos limita a ter que selecionar o mesmo número de tabelas para que possamos prosseguir com a união. No entanto, o mesmo resultado pode ser obtido usando a função JOIN do MySQL, neste caso, para vincular as tabelas com sua chave comum, usamos INNER JOIN e LEFT JOIN para que determinem quais tabelas não precisam ser exibidas no momento da exibição, mas que precisam estar ali para conectar as informações de uma tabelas a outra.

#### Infelizmente, não há muito para detalhar este código, pois é uma junção de JOIN's com um comando SELECT e suas colunas selecionadas. No entanto, é possivel mostrar o formato das estruturas, o comando ficara desta forma:

#### "SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_funcionario, CONCAT(dependente.nome_dependente, " ",funcionario.nome_meio, " ",funcionario.ultimo_nome) AS nome_completo_dependente, year(curdate()) - year(dependente.data_nascimento) AS idade_dependente, CASE dependente.sexo WHEN 'M' THEN 'Masculino' WHEN 'F' THEN 'Feminino' END AS sexo_dependente FROM dependente LEFT JOIN funcionario ON (dependente.cpf_funcionario=funcionario.cpf) INNER JOIN departamento ON (funcionario.numero_departamento=departamento.numero_departamento);"

#### A tabela retornara assim:

| nome_departamento | nome_completo_funcionario | nome_completo_dependente | idade_dependente | sexo_dependente |
|-------------------|---------------------------|--------------------------|------------------|-----------------|
| Pesquisa          | João B Silva              | Alicia B Silva           |               34 | Feminino        |
| Pesquisa          | João B Silva              | Elizabeth B Silva        |               55 | Feminino        |
| Pesquisa          | João B Silva              | Michael B Silva          |               34 | Masculino       |
| Pesquisa          | Fernando T Wong           | Alicia T Wong            |               36 | Feminino        |
| Pesquisa          | Fernando T Wong           | Janaina T Wong           |               64 | Feminino        |
| Pesquisa          | Fernando T Wong           | Tiago T Wong             |               39 | Masculino       |
| Administração     | Jennifer S Souza          | Antonio S Souza          |               80 | Masculino       |


## QUESTÃO 07: X
### prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.

#### "SELECT departamento.nome_departamento, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS nome_completo_funcionario, funcionario.salario FROM funcionario LEFT JOIN dependente ON funcionario.cpf = dependente.cpf_funcionario INNER JOIN departamento ON funcionario.numero_departamento = departamento.numero_departamento WHERE dependente.cpf_funcionario IS null;"

#### A tabela retornara assim:

| nome_departamento | nome_completo_funcionario | salario  |
|-------------------|---------------------------|----------|
| Pesquisa          | Joice A Leite             | 25000.00 |
| Pesquisa          | Ronaldo K Lima            | 38000.00 |
| Matriz            | Jorge E Brito             | 55000.00 |
| Administração     | André V Pereira           | 25000.00 |
| Administração     | Alice J Zelaya            | 25000.00 |


## QUESTÃO 08: X
### prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.

#### "SELECT CONCAT("Departamento ", departamento.numero_departamento, " ", departamento.nome_departamento) AS departamento_e_nome, projeto.nome_projeto, CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) AS nome_completo_funcionario, trabalha_em.horas FROM funcionario INNER JOIN departamento ON funcionario.numero_departamento = departamento.numero_departamento INNER JOIN projeto AS p ON departamento.numero_departamento = p.numero_departamento INNER JOIN trabalha_em ON funcionario.cpf = trabalha_em.cpf_funcionario INNER JOIN projeto ON trabalha_em.numero_projeto = projeto.numero_projeto WHERE funcionario.numero_departamento = projeto.numero_departamento GROUP BY departamento_e_nome, nome_projeto, nome_completo_funcionario, horas;"

#### A tabela retornara assim:

| departamento_e_nome            | nome_projeto    | nome_completo_funcionario | horas |
|--------------------------------|-----------------|---------------------------|-------|
| Departamento 1 Matriz          | Reorganização   | Jorge E Brito             |   0.0 |
| Departamento 4 Administração   | Informação      | Alice J Zelaya            |  10.0 |
| Departamento 4 Administração   | Informação      | André V Pereira           |  35.0 |
| Departamento 4 Administração   | Novosbeneficios | Alice J Zelaya            |  30.0 |
| Departamento 4 Administração   | Novosbeneficios | André V Pereira           |   5.0 |
| Departamento 4 Administração   | Novosbeneficios | Jennifer S Souza          |  20.0 |
| Departamento 5 Pesquisa        | ProdutoX        | João B Silva              |  32.5 |
| Departamento 5 Pesquisa        | ProdutoX        | Joice A Leite             |  20.0 |
| Departamento 5 Pesquisa        | ProdutoY        | Fernando T Wong           |  10.0 |
| Departamento 5 Pesquisa        | ProdutoY        | João B Silva              |   7.5 |
| Departamento 5 Pesquisa        | ProdutoY        | Joice A Leite             |  20.0 |



## QUESTÃO 09: XV
### prepare um relatório que mostre a soma total das horas de cada projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, o nome do projeto e a soma total das horas.

#### "SELECT DISTINCT departamento.nome_departamento, projeto.nome_projeto, sum(trabalha_em.horas) AS soma_das_horas FROM (departamento, projeto, trabalha_em) INNER JOIN departamento AS d ON (projeto.numero_departamento = d.numero_departamento) INNER JOIN trabalha_em AS tb ON (projeto.numero_projeto = tb.numero_projeto) GROUP BY nome_projeto, nome_departamento;"

#### A tabela retornara assim:

| nome_departamento | nome_projeto    | soma_das_horas |
|-------------------|-----------------|----------------|
| Administração     | Informação      |          825.0 |
| Matriz            | Informação      |          825.0 |
| Pesquisa          | Informação      |          825.0 |
| Administração     | Novosbeneficios |          825.0 |
| Matriz            | Novosbeneficios |          825.0 |
| Pesquisa          | Novosbeneficios |          825.0 |
| Administração     | ProdutoX        |          550.0 |
| Matriz            | ProdutoX        |          550.0 |
| Pesquisa          | ProdutoX        |          550.0 |
| Administração     | ProdutoY        |          825.0 |
| Matriz            | ProdutoY        |          825.0 |
| Pesquisa          | ProdutoY        |          825.0 |
| Administração     | ProdutoZ        |          550.0 |
| Matriz            | ProdutoZ        |          550.0 |
| Pesquisa          | ProdutoZ        |          550.0 |
| Administração     | Reorganização   |          825.0 |
| Matriz            | Reorganização   |          825.0 |
| Pesquisa          | Reorganização   |          825.0 |



## QUESTÃO 10: 
### prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
### A questão 10 esta repetindo a questão 1 a resposta ficara:
#### "select avg(salario) from funcionario;" sera exibido a media salarial dos funcionarios que é de: 35125.00

#### Tabela a ser exibida:
| avg(salario) |
|--------------|
| 35125.000000 |


## QUESTÃO 11: XV
### considerando que o valor pago por hora trabalhada em um projeto é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.

#### "select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo_funcionario, projeto.nome_projeto, trabalha_em.horas, sum(trabalha_em.horas)*0.50 as recebimento_horas from (funcionario, projeto, trabalha_em) inner join departamento as d on (projeto.numero_departamento = d.numero_departamento) inner join trabalha_em as tb on (projeto.numero_projeto = tb.numero_projeto) where funcionario.cpf = trabalha_em.cpf_funcionario group by nome_completo_funcionario, nome_projeto, nome_departamento, horas;"

#### Tabela a ser exibida:

| nome_completo_funcionario | nome_projeto    | horas | recebimento_horas |
|---------------------------|-----------------|-------|-------------------|
| Alice J Zelaya            | Informação      |  10.0 |            15.000 |
| Alice J Zelaya            | Informação      |  30.0 |            45.000 |
| Alice J Zelaya            | Novosbeneficios |  10.0 |            15.000 |
| Alice J Zelaya            | Novosbeneficios |  30.0 |            45.000 |
| Alice J Zelaya            | ProdutoX        |  10.0 |            10.000 |
| Alice J Zelaya            | ProdutoX        |  30.0 |            30.000 |
| Alice J Zelaya            | ProdutoY        |  10.0 |            15.000 |
| Alice J Zelaya            | ProdutoY        |  30.0 |            45.000 |
| Alice J Zelaya            | ProdutoZ        |  10.0 |            10.000 |
| Alice J Zelaya            | ProdutoZ        |  30.0 |            30.000 |
| Alice J Zelaya            | Reorganização   |  10.0 |            15.000 |
| Alice J Zelaya            | Reorganização   |  30.0 |            45.000 |
| André V Pereira           | Informação      |   5.0 |             7.500 |
| André V Pereira           | Informação      |  35.0 |            52.500 |
| André V Pereira           | Novosbeneficios |   5.0 |             7.500 |
| André V Pereira           | Novosbeneficios |  35.0 |            52.500 |
| André V Pereira           | ProdutoX        |   5.0 |             5.000 |
| André V Pereira           | ProdutoX        |  35.0 |            35.000 |
| André V Pereira           | ProdutoY        |   5.0 |             7.500 |
| André V Pereira           | ProdutoY        |  35.0 |            52.500 |
| André V Pereira           | ProdutoZ        |   5.0 |             5.000 |
| André V Pereira           | ProdutoZ        |  35.0 |            35.000 |
| André V Pereira           | Reorganização   |   5.0 |             7.500 |
| André V Pereira           | Reorganização   |  35.0 |            52.500 |
| Fernando T Wong           | Informação      |  10.0 |            60.000 |
| Fernando T Wong           | Novosbeneficios |  10.0 |            60.000 |
| Fernando T Wong           | ProdutoX        |  10.0 |            40.000 |
| Fernando T Wong           | ProdutoY        |  10.0 |            60.000 |
| Fernando T Wong           | ProdutoZ        |  10.0 |            40.000 |
| Fernando T Wong           | Reorganização   |  10.0 |            60.000 |
| Jennifer S Souza          | Informação      |  15.0 |            22.500 |
| Jennifer S Souza          | Informação      |  20.0 |            30.000 |
| Jennifer S Souza          | Novosbeneficios |  15.0 |            22.500 |
| Jennifer S Souza          | Novosbeneficios |  20.0 |            30.000 |
| Jennifer S Souza          | ProdutoX        |  15.0 |            15.000 |
| Jennifer S Souza          | ProdutoX        |  20.0 |            20.000 |
| Jennifer S Souza          | ProdutoY        |  15.0 |            22.500 |
| Jennifer S Souza          | ProdutoY        |  20.0 |            30.000 |
| Jennifer S Souza          | ProdutoZ        |  15.0 |            15.000 |
| Jennifer S Souza          | ProdutoZ        |  20.0 |            20.000 |
| Jennifer S Souza          | Reorganização   |  15.0 |            22.500 |
| Jennifer S Souza          | Reorganização   |  20.0 |            30.000 |
| João B Silva              | Informação      |   7.5 |            11.250 |
| João B Silva              | Informação      |  32.5 |            48.750 |
| João B Silva              | Novosbeneficios |   7.5 |            11.250 |
| João B Silva              | Novosbeneficios |  32.5 |            48.750 |
| João B Silva              | ProdutoX        |   7.5 |             7.500 |
| João B Silva              | ProdutoX        |  32.5 |            32.500 |
| João B Silva              | ProdutoY        |   7.5 |            11.250 |
| João B Silva              | ProdutoY        |  32.5 |            48.750 |
| João B Silva              | ProdutoZ        |   7.5 |             7.500 |
| João B Silva              | ProdutoZ        |  32.5 |            32.500 |
| João B Silva              | Reorganização   |   7.5 |            11.250 |
| João B Silva              | Reorganização   |  32.5 |            48.750 |
| Joice A Leite             | Informação      |  20.0 |            60.000 |
| Joice A Leite             | Novosbeneficios |  20.0 |            60.000 |
| Joice A Leite             | ProdutoX        |  20.0 |            40.000 |
| Joice A Leite             | ProdutoY        |  20.0 |            60.000 |
| Joice A Leite             | ProdutoZ        |  20.0 |            40.000 |
| Joice A Leite             | Reorganização   |  20.0 |            60.000 |
| Jorge E Brito             | Informação      |   0.0 |             0.000 |
| Jorge E Brito             | Novosbeneficios |   0.0 |             0.000 |
| Jorge E Brito             | ProdutoX        |   0.0 |             0.000 |
| Jorge E Brito             | ProdutoY        |   0.0 |             0.000 |
| Jorge E Brito             | ProdutoZ        |   0.0 |             0.000 |
| Jorge E Brito             | Reorganização   |   0.0 |             0.000 |
| Ronaldo K Lima            | Informação      |  40.0 |            60.000 |
| Ronaldo K Lima            | Novosbeneficios |  40.0 |            60.000 |
| Ronaldo K Lima            | ProdutoX        |  40.0 |            40.000 |
| Ronaldo K Lima            | ProdutoY        |  40.0 |            60.000 |
| Ronaldo K Lima            | ProdutoZ        |  40.0 |            40.000 |
| Ronaldo K Lima            | Reorganização   |  40.0 |            60.000 |

## QUESTÃO 12: 
### seu chefe está verificando as horas trabalhadas pelos funcionários nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste o nome do departamento, o nome do projeto e o nome dos funcionários que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.

#### "select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, " ", funcionario.ultimo_nome) as nome_completo, departamento.nome_departamento, projeto.nome_projeto from (funcionario, departamento, projeto) inner join funcionario as f on (departamento.cpf_gerente = f.cpf) inner join projeto as p on (departamento.numero_departamento = p.numero_departamento) inner join trabalha_em as tb on (p.numero_projeto = tb.numero_projeto) where tb.horas = 0.0 and funcionario.cpf = tb.cpf_funcionario group by projeto.nome_projeto, departamento.nome_departamento, nome_completo;"

#### Tabela a ser exibida:

| nome_completo | nome_departamento | nome_projeto    |
|---------------|-------------------|-----------------|
| Jorge E Brito | Matriz            | Informação      |
| Jorge E Brito | Matriz            | Novosbeneficios |
| Jorge E Brito | Matriz            | ProdutoX        |
| Jorge E Brito | Matriz            | ProdutoY        |
| Jorge E Brito | Matriz            | ProdutoZ        |
| Jorge E Brito | Matriz            | Reorganização   |



## QUESTÃO 13: X
### durante o natal deste ano a empresa irá presentear todos os funcionários e todos os dependentes (sim, a empresa vai dar um presente para cada funcionário e um presente para cada dependente de cada funcionário) e pediu para que você preparasse um relatório que listasse o nome completo das pessoas a serem presenteadas (funcionários e dependentes), o sexo e a idade em anos completos (para poder comprar um presente adequado). Esse relatório deve estar ordenado pela idade em anos completos, de forma decrescente.

#### "


## QUESTÃO 14: X
### prepare um relatório que exiba quantos funcionários cada departamento tem.

#### "


## QUESTÃO 15: 
### como um funcionário pode estar alocado em mais de um projeto, prepare um relatório que exiba o nome completo do funcionário, o departamento desse funcionário e o nome dos projetos em que cada funcionário está alocado. Atenção: se houver algum funcionário que não está alocado em nenhum projeto, o nome completo e o departamento também devem aparecer no relatório.

#### SELECT DISTINCT CONCAT(f.primeiro_nome, " ", f.nome_meio, " ", f.ultimo_nome) AS "Nomes_completos:",
 dpt.nome_departamento AS "Departamentos:", p.nome_projeto AS "Projetos:"
 from departamento AS dpt
 inner join projeto AS p 
 inner join trabalha_em AS tb 
 inner join funcionario AS f 
 where dpt.numero_departamento = f.numero_departamento 
 and p.numero_projeto = tb.numero_projeto 
 and tb.cpf_funcionario = f.cpf
 order by p.nome_projeto desc;

#### Tabela a ser exibida:

| Nomes_Completos: | Departamentos:  | Projetos:       |
|------------------|-----------------|-----------------|
| Fernando T Wong  | Pesquisa        | Reorganização   |
| Jorge E Brito    | Matriz          | Reorganização   |
| Jennifer S Souza | Administração   | Reorganização   |
| Fernando T Wong  | Pesquisa        | ProdutoZ        |
| Ronaldo K Lima   | Pesquisa        | ProdutoZ        |
| João B Silva     | Pesquisa        | ProdutoY        |
| Fernando T Wong  | Pesquisa        | ProdutoY        |
| Joice A Leite    | Pesquisa        | ProdutoY        |
| João B Silva     | Pesquisa        | ProdutoX        |
| Joice A Leite    | Pesquisa        | ProdutoX        |
| Jennifer S Souza | Administração   | Novosbeneficios |
| André V Pereira  | Administração   | Novosbeneficios |
| Alice J Zelaya   | Administração   | Novosbeneficios |
| Fernando T Wong  | Pesquisa        | Informação      |
| André V Pereira  | Administração   | Informação      |
| Alice J Zelaya   | Administração   | Informação      |











