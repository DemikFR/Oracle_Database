--Função para preencher todos os caracteres. Regra de Negócio 12
CREATE OR REPLACE FUNCTION tratar_PKs(codigo IN NUMBER, max_caractere IN NUMBER)
    RETURN VARCHAR
    IS codigo_tratado VARCHAR(15);
    BEGIN
        codigo_tratado := TO_CHAR(LPAD(codigo, max_caractere, 0));
        RETURN codigo_tratado;
    END;
/
--Função para atribuir a categoria(tabela categoria_pesquisa) o nome IC(Iniciação cientifíca) ou IT(Iniciação Tecnologia). 
--Regra de Negócio 10
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
/
--Função para verificar se o ano inserido na tabela Projeto é válido ou não. 
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
/
CREATE SEQUENCE sq_cd_bolsa
    MINVALUE 1
    MAXVALUE 9999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    CYCLE;
/
CREATE OR REPLACE TRIGGER insert_aluno 
BEFORE INSERT ON aluno 
FOR EACH ROW 
BEGIN
    :NEW.matricula := tratar_PKs(:NEW.matricula, 11);
    :NEW.nm_aluno := UPPER(:NEW.nm_aluno); -- Regra de Negócio 15
END;
/
--Preciso ARRUMAR, após ser colocado o sistema de SEQUENCE
CREATE OR REPLACE TRIGGER insert_bolsa 
BEFORE INSERT ON bolsa 
FOR EACH ROW 
BEGIN 
    :NEW.cd_bolsa := tratar_PKs(sq_cd_bolsa.NEXTVAL, 7);
    :NEW.id_discente := tratar_PKs(:NEW.id_discente, 8);
    :NEW.id_unidade := tratar_PKs(:NEW.id_unidade, 5);
    :NEW.id_pesquisa := tratar_PKs(:NEW.id_pesquisa, 5);
    :NEW.tipo_bolsa := UPPER(:NEW.tipo_bolsa); -- Regra de Negócio 15
END; 
/
CREATE OR REPLACE TRIGGER insert_bolsista 
BEFORE INSERT ON bolsista 
FOR EACH ROW 
BEGIN 
    :NEW.id_discente := tratar_PKs(:NEW.id_discente, 8);
    :NEW.matricula := tratar_PKs(:NEW.matricula, 11);
    :NEW.id_orientador := tratar_PKs(:NEW.id_orientador, 7);
    :NEW.id_grupo := tratar_PKs(:NEW.id_grupo, 9);
END; 
/
CREATE OR REPLACE TRIGGER insert_categoria_pesquisa 
BEFORE INSERT ON categoria_pesquisa 
FOR EACH ROW 
BEGIN
    :NEW.cd_categoria := UPPER(tratar_categoria(:NEW.categoria)); -- Regra de Negócio 10
    :NEW.categoria := UPPER(:NEW.categoria); 
END; 
/
CREATE OR REPLACE TRIGGER insert_grupo_pesquisa 
BEFORE INSERT ON grupo_pesquisa
FOR EACH ROW 
BEGIN 
    :NEW.id_grupo := tratar_PKs(:NEW.id_grupo, 9);
    :NEW.nm_grupo := UPPER(:NEW.nm_grupo); -- Regra de Negócio 15
END; 
/
CREATE OR REPLACE TRIGGER insert_orientador 
BEFORE INSERT ON orientador 
FOR EACH ROW 
BEGIN 
    :NEW.id_orientador := tratar_PKs(:NEW.id_orientador, 7);
    :NEW.id_grupo := tratar_PKs(:NEW.id_grupo, 9);
    :NEW.nm_orientador := UPPER(:NEW.nm_orientador); -- Regra de Negócio 15
END; 
/
CREATE OR REPLACE TRIGGER insert_pesquisa 
BEFORE INSERT ON pesquisa 
FOR EACH ROW 
BEGIN 
    :NEW.id_pesquisa := tratar_PKs(:NEW.id_pesquisa, 9);
    :NEW.status := UPPER(:NEW.status);
    :NEW.linha_pesquisa := UPPER(:NEW.linha_pesquisa); -- Regra de Negócio 15
END; 
/
--Trigger que verifica se o ano à ser inserido na tabela Projeto é válido ou não.
CREATE OR REPLACE TRIGGER insert_projeto 
BEFORE INSERT ON projeto 
FOR EACH ROW 
BEGIN 
    IF verificar_ano_projeto(:NEW.ano) = 'Invalido' THEN
        RAISE_APPLICATION_ERROR(-20010, 'Ano Invalido');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER insert_projeto_pesquisa
BEFORE INSERT ON projeto_pesquisa 
FOR EACH ROW 
BEGIN 
    :NEW.cd_projeto_pesquisa := tratar_PKs(:NEW.cd_projeto_pesquisa, 8);
    :NEW.cd_categoria := tratar_categoria(:NEW.cd_categoria);
    :NEW.id_pesquisa := tratar_PKs(:NEW.id_pesquisa, 9);
    :NEW.titulo := UPPER(:NEW.titulo);
END;
/
CREATE OR REPLACE TRIGGER insert_unidade 
BEFORE INSERT ON unidade 
FOR EACH ROW 
BEGIN 
    :NEW.id_unidade := tratar_PKs(:NEW.id_unidade, 5);
    :NEW.nm_unidade := UPPER(:NEW.nm_unidade);
END;
/
CREATE OR REPLACE TRIGGER insert_unidade_aluno
BEFORE INSERT ON unidade_aluno 
FOR EACH ROW 
BEGIN 
    :NEW.matricula := tratar_PKs(:NEW.matricula, 11);
    :NEW.id_unidade := tratar_PKs(:NEW.id_unidade, 5);
END;

INSERT INTO categoria_pesquisa (categoria) VALUES ('Cientifica')