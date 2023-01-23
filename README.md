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
Nela terão os atributos matricula(FK de aluno) e ID unidade(FK de unidade), ambos serão primary, pois apenas eles já garantem a unicidade 
do registro.
		
- Projeto de pesquisa: são dados que dirão sobre o desenvolvimento da pesquisa, além de dizer os impactos. receberá CD projeto(conforme base, é um código composto por letras e números), título (breve descrição), ano.
		
- Pesquisa: diz do que a pesquisa se trata. Receberá ID pesquisa, CD projeto(FK de projeto), categoria (Iniciação Cientifíca ou Iniciação Tecnológica), status (se a pesquisa já terminou ou não), inicio pesquisa, linha pesquisa (breve descrição), fim (da pesquisa).
		
- Bolsa: esta entidade é para relacionar o bolsista com a(s) sua(s) pesquisa(s), garantindo a sua normalização. Ela também foi 
ajustada para se relacionar com a entidade unidade, garantindo o funcionamento conceitual do banco. Os atributos dela serão cd bolsa, 
ID unidade(FK de unidade), ID pesquisa(FK de pesquisa), ID discente(FK do bolsista), cota e tipo bolsa. Esses dois últimos são da base,
colocado nesta entidade para se adequar conceitualmente.

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

8 - A pesquisa deve ter um projeto, já o projeto deve ter um ou mais pesquisas.

9 - A bolsa deve ter uma unidade que deve ter uma ou mais bolsas.

10 - Os alunos devem ter uma unidade que foi matriculado, e a unidade pode ou não ter alunos.

11 - Todas as PK devem ter os seguintes números de carácteres: ID_discente = 8, matricula = 11, CD_projeto = 9, ID_orientador = 7, ID_grupo = 9, ID_unidade = 5, CD_bolsa = 9.

12 - Caso o ID/CD não tenha o tamanho máximo de carácteres, deve-se colocar 0 à esquerda do número, exceto os que tenham textos.

13 - No banco, todos os textos deverão estar em maiúscula.

14 - O campo de título não deverá ter valores nulos, caso tenha deve ser transformado para "NÃO INFORMADO".

15 - Caso o campo inicio ou fim estiverem nulos, deve ser usado os dados de cota para preenche-lo adequadamente.

16 - O campo do código de projeto deve ser composto apenas pelas letras iniciais e seu número, separando do ano, tornando a com no máximo 9 caractéres.

15 - Nos campos de texto é admitido todo tipo de caractéres, desde que começe e termine por letras.

<h2>📋Modelo Lógico</h2>
<div align=center>
	<img height="550" width="800" src="https://i.imgur.com/JtfjrwR.png">
</div>

<h2>📋Modelo Relacional</h2>
<div align=center>
	<img height="550" width="800" src="https://i.imgur.com/EdYD0ZE.png">
</div>

Para respeitar a 12 regra de negócio, todos os índices e códigos foram transformados em VARCHAR2.

<h2>🛠 Tecnologias</h2>

As seguintes ferramentas foram usadas na construção do projeto:

- [Oracle SQL](https://www.oracle.com/br/database/sqldeveloper/)
- [Jupyter Notebook](https://jupyter.org/)

<h2>📝 Licença</h2>

Este projeto esta sobe a licença MIT.
