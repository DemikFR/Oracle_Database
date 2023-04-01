<div align=center>
  <img height="300" width="400" src="https://www.ufrn.br/resources/documentos/identidadevisual/logotipo/logotipo_flat.png">
  <h1 align="center">Banco de Dados Oracle para a base de Bolsistas da UFRN</h1>
</div>
<div align="center">Projeto de banco de dados Oracle dos bolsistas de pesquisa da UFRN.<br><br></div>
Os dados se encontram na página de <a href="https://dados.ufrn.br/">dados abertos da UFRN</a> e na pasta "Base_Dados" deste repositório.<br><br>
<h3 align=center>🔨Projeto ainda em desenvolvimento.🔨</h3><br>

<h2>💽 Entidades:</h2>
Para se adequar às formas normais, foram criadas 9 entidades, cada uma com a sua chave primária de acordo com os 
Atributos disponibilizadas pela base e duas entidades associativas que receberão um código para cada relação. Assim, as entidades são:
	
- Grupo de pesquisa: conforme a base, ele tem o seu ID e nome, para cada grupo, terá seus discentes e docentes.
		
- Orientador: receberá o seu id da base, nome e a chave estrangeira do grupo à qual ele pertence.
		
- Aluno: terá a posibilidade de ser adicionado alunos ingresssantes da universidade. Receberá os atributos
matricula e o nome do aluno.
		
- Bolsista: Aluno que está sendo comtemplado pela bolsa. Os seus atributos serão o ID do discente, matricula(FK da entidade aluno), 
ID orientador(FK de seu orientador) e ID grupo(FK do grupo à qual ele pertence).
		
- Unidade: departamento/instituto/faculdade. Receberá o ID unidade e o nome da unidade.
		
- Unidade aluno: é a entidade associativa para relacionar a unidade com aluno, pois na ausência dela, os dados ficariam fora da forma normal.
Nela terão os atributos matricula(FK de aluno) e ID unidade(FK de unidade), ambos serão primary, pois apenas eles já garantem a unicidade do registro.
		
- Projeto de pesquisa: são dados que dirão sobre o desenvolvimento da pesquisa, além de dizer os impactos. receberá CD projeto(conforme base, é um código composto por letras e números), ano (inicial do projeto).
		
- Pesquisa: diz do que a pesquisa se trata. Receberá ID pesquisa, CD projeto(FK de projeto), cd status (FK se a pesquisa já terminou, em andamento ou há pendencias), inicio pesquisa, linha pesquisa (breve descrição), fim (da pesquisa).

- Status da Pesquisa: Em qual situação a pesquisa está no momento, existindo três opções: 1: EM ANDAMENTO; 2: PENDENTE DE RELATORIO; 3: FINALIZADO.
		
- Bolsa: esta entidade é para relacionar o bolsista com a(s) sua(s) pesquisa(s), garantindo a sua normalização. Ela também foi 
ajustada para se relacionar com a entidade unidade, garantindo o funcionamento conceitual do banco. Os atributos dela serão cd bolsa, 
ID unidade(FK de unidade), ID pesquisa(FK de pesquisa), ID discente(FK do bolsista) e tipo bolsa. Esse último é da base,
colocado nesta entidade para se adequar conceitualmente.

- Categoria: é o modelo de pesquisa do bolsista, que são Iniciação Científica e Iniciação Tecnologica. Os atributos dela serão cd categoria (IC ou IT) e Categoria, que no banco será Iniciação Científica, para IC e Iniciação Tecnologica para IT.

- Projeto Pesquisa: é a entidade associativa para Pesquisa e Projeto, pois ambas as entidades são relacionamento MxN, e muitas vezes, tem o mesmo código projeto e o mesmo ID pesquisa, mudando apenas o título. Os atributos dela serão: CD Projeto Pesquisa, será gerado sequencialmente; CD categoria (FK de categoria), que receberá 1 ou 2, respectivamente IC e IT; ID Pesquisa (FK de pesquisa); CD Projeto (FK de projeto).

<h2>📜 Conforme a análise dos dados disponibilizados, foram estabelecidas as seguintes <b>RNs</b>: 	</h2>
	
1 - Poderá ser armazenado diversos alunos da universidade, porém alguns deles são ou não comtemplados com a bolsa de 
Pesquisa, os que são, ganham um id especial como bolsista.

2 - Um aluno pode ou não ser bolsista, já está sendo considerada a posibilidade de ser cadastrado alunos que 
Possivelmente podem se tornar bolsistas.

3 - Grupo de pesquisa só se relacionará com os bolsista e orientador, pois não há alunos com pesquisas sem bolsas.

4 - Um bolsista pode ou não pertencer a um grupo

5 - Bolsista e orientador devem ter relacionamento um com o outro.

6 - Um bolsista deve estar em uma ou muitas bolsas.

7 - Uma bolsa deve estar em uma pesquisa, a pesquisa deve ter uma ou mais bolsa.

8 - A pesquisa deve ter um ou mais de um projeto, assim como o projeto deve ter um ou mais pesquisas.

9 - A pode ter deve ter apenas um status, enquanto o status pode ter um ou mais pesquisas

10 - A categoria de bolsa é mandatória.

11 - Na PK de Categoria, deve ser IC para Iniciação Cienrtifíca ou IT para Iniciação Tecnológica.

12 - A bolsa deve ter uma unidade que deve ter uma ou mais bolsas.

13 - Os alunos devem ter uma unidade que foi matriculado, e a unidade pode ou não ter alunos.

14 - Todas as PK devem ter os seguintes números de carácteres: ID_discente = 8, matricula = 11, CD_projeto = 9, 
CD_projeto_pesquisa = 8, CD_categoria = 2, ID_orientador = 7, ID_grupo = 11, ID_unidade = 5, ID_PESQUISA = 9, CD_bolsa = 7.

15 - Caso o ID/CD não tenha o tamanho máximo de carácteres, deve-se colocar 0 à esquerda do número, exceto os que tenham textos.

16 - No banco, todos os textos deverão estar em maiúscula.

17 - O campo de título e grupo de pesquisa não deverão ter valores nulos, caso tenha, deve ser transformado para "NÃO INFORMADO".

18 - Caso o campo inicio ou fim estiverem nulos, deve ser usado os dados de cota para preenche-los adequadamente.

19 - O campo do código de projeto deve ser composto apenas pelas letras iniciais e seu número, separando do ano, tornando a com no máximo 9 caractéres.

20 - Nos campos de texto é admitido todo tipo de caractéres, desde que começe e termine por letras.

<h2>📋Modelo Lógico</h2>
<div align=center>
	<img height="550" width="800" src="https://user-images.githubusercontent.com/102700735/229260008-8301e3a1-3f70-4335-9604-add3b2ec17f4.png">
</div>

<h2>📋Modelo Relacional</h2>
<div align=center>
	<img height="550" width="800" src="https://user-images.githubusercontent.com/102700735/229260097-1e8f36fd-3c24-4366-95f0-9ae7fe1f2e09.png">
</div>

Para respeitar a 15 regra de negócio, todos os índices e códigos foram transformados em VARCHAR2.

<h2>📋Funções e Triggers</h2>

Antes da carga de dados, foi criada um script contendo três funções e uma trigger para cada tabela do banco para respeitar as regras de negócio e manter a integridade do banco.

Primeiramente, foi criada a Função "tratar_PKs" que servirá para atender a RN 14. Nela é requerido dois campos de entrada, sendo eles, "codigo", que é do tipo number e receberá o código PK a ser inserido, e o "max_caractere", que receberá o tamanho do campo. A função retornará uma varíavel do tipo "Varchar" que, recebe o valor do comando LPAD, onde é atribuido o código dado pela função com a quantidade de caracteres determinada, por exemplo, um código "1", com um tamanho 4, ficará "0001".

O código da função no script:
~~~sql 
CREATE OR REPLACE FUNCTION tratar_PKs(codigo IN NUMBER, max_caractere IN NUMBER)
    RETURN VARCHAR
    IS codigo_tratado VARCHAR(15);
    BEGIN
        codigo_tratado := TO_CHAR(LPAD(codigo, max_caractere, 0));
        RETURN codigo_tratado;
    END;
~~~

Quando ela ser chamada na função, receberá como código a variável :NEW.'Campo' do PL/SQL, conforme a trigger da tabela aluno:

~~~sql
CREATE OR REPLACE TRIGGER insert_aluno 
BEFORE INSERT ON aluno 
FOR EACH ROW 
BEGIN
   :NEW.matricula := tratar_PKs(:NEW.matricula, 11);
   :NEW.nm_aluno := UPPER(:NEW.nm_aluno); -- Regra de Negócio 13
END;
~~~

Para garantir a RN 16, todas os campos de texto serão alterados com o comando UPPER, conforme o "nm_aluno" da trigger acima.

Para a tabela categoria, foi criada uma função que através de um comando REGEX, verificará se no dado a ser inserido na descrição de categoria, conterá, Cien ou Tec, assim, quando for a primeira, mudará o campo CD_Categoria para 'IC', já no segundo caso, o campo será IT, conforme a RN 11.

~~~sql
--Função para adicionar o código da Categoria.
CREATE OR REPLACE FUNCTION tratar_categoria(categoria IN VARCHAR)
    RETURN VARCHAR
    IS categoria_tratada VARCHAR(2);
    BEGIN
        IF REGEXP_LIKE(categoria, '(cien)|(Cien)|(CIEN)') THEN
            categoria_tratada := 'IC';
            RETURN categoria_tratada;
        ELSIF REGEXP_LIKE(categoria, '(T|t)(é|e)c') THEN
            categoria_tratada := 'IT';
            RETURN categoria_tratada;
        ELSE
            raise_application_error(-20000,'Categoria de Bolsa não reconhecida');
        END IF;
    END;
--Trigger que chamará a função e irá atribuir ao cd_categoria o seu valor de retorno (Note que nas FKs, será realizado um processo semelhante)
CREATE OR REPLACE TRIGGER insert_categoria_pesquisa 
BEFORE INSERT ON categoria_pesquisa 
FOR EACH ROW 
BEGIN
    :NEW.cd_categoria := UPPER(tratar_categoria(:NEW.categoria)); -- Regra de Negócio 10
    :NEW.categoria := UPPER(:NEW.categoria); 
END; 
~~~

A terceira função será apenas para verificar se foi inserido no "ano" da tabela "Projeto" um número válido. Ele receberá o valor ":NEW" da trigger, e usará um REGEX para saber se é um número de ano válido ou inválido. A trigger irá usar usa condição do tipo IF, se caso caso o retorno da função for "Valido", ela irá prosseguir normalmente, caso o contrário irá resultar um erro com a procedure interna da Oracle "Raise_Application_Error", conforme no código abaixo: 

~~~sql
--Função que verifica o ano
CREATE OR REPLACE FUNCTION verificar_ano_projeto(ano IN NUMBER)
    RETURN VARCHAR
    IS
    BEGIN
        IF REGEXP_LIKE(ano, '(20[0-9]{2})|(19[0-9]{2})') THEN
            RETURN 'Valido';
        ELSE
            RETURN 'Invalido';
        END IF;
    END;
--Trigger da tabela "Projeto"
CREATE OR REPLACE TRIGGER insert_projeto 
BEFORE INSERT ON projeto 
FOR EACH ROW 
BEGIN 
    IF verificar_ano_projeto(:NEW.ano) = 'Invalido' THEN
        RAISE_APPLICATION_ERROR(-20010, 'Ano Invalido');
    END IF;
END;
~~~

Todas as outras triggers das tabelas, seguem o mesmo padrão das usadas de exemplo.


<h2>🛠 Tecnologias</h2>

As seguintes ferramentas foram usadas na construção do projeto:

- [Oracle SQL](https://www.oracle.com/br/database/sqldeveloper/)
- [Jupyter Notebook](https://jupyter.org/)

<h2>📝 Licença</h2>

Este projeto esta sobe a licença MIT.
