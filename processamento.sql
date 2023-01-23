--Fun��o para preencher todos os caracteres. Regra de Neg�cio 12
CREATE OR REPLACE FUNCTION tratar_PKs(codigo IN NUMBER, max_caractere IN NUMBER)
    RETURN VARCHAR
    IS codigo_tratado VARCHAR(15);
    BEGIN
        codigo_tratado := to_char(lpad(codigo, max_caractere, 0));
        return codigo_tratado;
    END;
    
CREATE SEQUENCE sq_cd_bolsa
    MINVALUE 1
    MAXVALUE 9999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    CYCLE;


SET SERVEROUTPUT ON
select tratar_textos('Corporeidade e educa��o - forma��o e autoforma��o humanescente
') FROM DUAL;

CREATE OR REPLACE TRIGGER insert_aluno 
BEFORE INSERT ON aluno 
FOR EACH ROW 
BEGIN
   :NEW.matricula := tratar_PKs(:NEW.matricula, 11);
   :NEW.nm_aluno := upper(:NEW.nm_aluno); -- Regra de Neg�cio 13
END;

--Preciso ARRUMAR, ap�s ser colocado o sistema de SEQUENCE
CREATE OR REPLACE TRIGGER insert_bolsa 
BEFORE INSERT ON bolsa 
FOR EACH ROW 
BEGIN 
   :NEW.cd_bolsa := tratar_PKs(sq_cd_bolsa.NEXTVAL, 7);
   :NEW.tipo_bolsa := upper(:NEW.tipo_bolsa); -- Regra de Neg�cio 13
END; 

CREATE OR REPLACE TRIGGER insert_bolsista 
BEFORE INSERT ON bolsista 
FOR EACH ROW 
BEGIN 
   :NEW.id_discente := tratar_PKs(:NEW.id_discente, 8);
END; 

CREATE OR REPLACE TRIGGER insert_grupo_pesquisa 
BEFORE INSERT ON grupo_pesquisa 
FOR EACH ROW 
BEGIN 
   :NEW.id_grupo := tratar_PKs(:NEW.id_grupo, 9);
   :NEW.nm_bolsa := upper(:NEW.nm_bolsa); -- Regra de Neg�cio 13
END; 

CREATE OR REPLACE TRIGGER insert_orientador 
BEFORE INSERT ON orientador 
FOR EACH ROW 
BEGIN 
   :NEW.id_orientador := tratar_PKs(:NEW.id_orientador, 7);
   :NEW.nm_orientador := upper(:NEW.nm_orientador); -- Regra de Neg�cio 13
END; 

CREATE OR REPLACE TRIGGER insert_pesquisa 
BEFORE INSERT ON pesquisa 
FOR EACH ROW 
BEGIN 
   :NEW.id_pesquisa := tratar_PKs(:NEW.id_pesquisa, 9);
   :NEW.categoria := upper(:NEW.categoria); -- Regra de Neg�cio 13
   IF REGEXP_LIKE(:NEW.categoria, 'Tec|T�c', 'i') THEN 
    :NEW.categoria := 'IT';
   ELSIF REGEXP_LIKE(:NEW.categoria, 'Cie|Ci�', 'i') THEN
    :NEW.categoria := 'IC';
   ELSE
    raise_application_error(-20000,'Categoria de Bolsa n�o reconhecida');
   END IF;
   :NEW.linha_pesquisa := upper(:NEW.linha_pesquisa); -- Regra de Neg�cio 13
END; 

/*
CREATE OR REPLACE TRIGGER insert_projeto 
BEFORE INSERT ON pesquisa 
FOR EACH ROW 
BEGIN 
   --:NEW.id_pesquisa := tratar_PKs(:NEW.id_pesquisa, 9);
END;
*/

CREATE OR REPLACE TRIGGER insert_unidade 
BEFORE INSERT ON pesquisa 
FOR EACH ROW 
BEGIN 
   :NEW.id_unidade := tratar_PKs(:NEW.id_unidade, 5);
END; 
/

INSERT INTO projeto VALUES('ABC12', 'ABCDEC', '12', 'Processos e Transtornos da Audi��o e da Linguagem na inf�ncia',
'121');

insert into pesquisa VALUES('255', 'ABC12', 'Inicia��o de Ci�ncia', 'Finalizado', '22/10/2022', 'Processos e Transtornos da Audi��o e da Linguagem na inf�ncia',
'12/12/2022');

SELECT * FROM pesquisa;

delete from pesquisa

SELECT REGEXP_REPLACE(';;;  	   	     	  Corporeidade e educa��o: forma��o e autoforma��o humanescente;
', '[]~!@#$%^&*()_+=\{}[:�;�<,>./?]+','') FROM DUAL; USAR PL/SQL AQUI

REGEXP_REPLACE(str,
