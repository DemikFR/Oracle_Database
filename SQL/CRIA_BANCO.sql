CREATE TABLE aluno (
    matricula VARCHAR2(11) NOT NULL,
    nm_aluno  VARCHAR2(72) NOT NULL
);

ALTER TABLE aluno ADD CONSTRAINT aluno_pk PRIMARY KEY ( matricula );

CREATE TABLE bolsa (
    cd_bolsa    VARCHAR2(7) NOT NULL,
    id_discente VARCHAR2(8) NOT NULL,
    id_unidade  VARCHAR2(5) NOT NULL,
    id_pesquisa VARCHAR2(9) NOT NULL,
    tipo_bolsa  VARCHAR2(17) NOT NULL
);

ALTER TABLE bolsa ADD CONSTRAINT bolsa_pk PRIMARY KEY ( cd_bolsa );

CREATE TABLE bolsista (
    id_discente   VARCHAR2(8) NOT NULL,
    matricula     VARCHAR2(11) NOT NULL,
    id_orientador VARCHAR2(7) NOT NULL,
    id_grupo      VARCHAR2(9)
);

ALTER TABLE bolsista ADD CONSTRAINT bolsista_pk PRIMARY KEY ( id_discente );

CREATE TABLE categoria_pesquisa (
    cd_categoria NUMBER NOT NULL,
    categoria    VARCHAR2(35) NOT NULL
);

ALTER TABLE categoria_pesquisa ADD CONSTRAINT categoria_pk PRIMARY KEY ( cd_categoria );

CREATE TABLE grupo_pesquisa (
    id_grupo VARCHAR2(9) NOT NULL,
    nm_grupo VARCHAR2(113) NOT NULL
);

ALTER TABLE grupo_pesquisa ADD CONSTRAINT grupo_pesquisa_pk PRIMARY KEY ( id_grupo );

CREATE TABLE orientador (
    id_orientador VARCHAR2(7) NOT NULL,
    id_grupo      VARCHAR2(9),
    nm_orientador VARCHAR2(53) NOT NULL
);

ALTER TABLE orientador ADD CONSTRAINT orientador_pk PRIMARY KEY ( id_orientador );

CREATE TABLE pesquisa (
    id_pesquisa     VARCHAR2(9) NOT NULL,
    status          VARCHAR2(21) NOT NULL,
    inicio_pesquisa DATE NOT NULL,
    linha_pesquisa  VARCHAR2(199),
    fim_pesquisa    DATE
);

ALTER TABLE pesquisa ADD CONSTRAINT pesquisa_pk PRIMARY KEY ( id_pesquisa );

CREATE TABLE projeto (
    codigo_projeto VARCHAR2(9) NOT NULL,
    ano            NUMBER(4) NOT NULL
);

ALTER TABLE projeto ADD CONSTRAINT projeto_pk PRIMARY KEY ( codigo_projeto );

CREATE TABLE projeto_pesquisa (
    cd_projeto_pesquisa VARCHAR2(8) NOT NULL,
    cd_categoria        NUMBER NOT NULL,
    id_pesquisa         VARCHAR2(9) NOT NULL,
    codigo_projeto      VARCHAR2(9) NOT NULL,
    titulo              VARCHAR2(298) NOT NULL
);

ALTER TABLE projeto_pesquisa ADD CONSTRAINT projeto_pesquisa_pk PRIMARY KEY ( cd_projeto_pesquisa );

CREATE TABLE unidade (
    id_unidade VARCHAR2(5) NOT NULL,
    nm_unidade VARCHAR2(116) NOT NULL
);

ALTER TABLE unidade ADD CONSTRAINT unidade_pk PRIMARY KEY ( id_unidade );

CREATE TABLE unidade_aluno (
    matricula  VARCHAR2(11) NOT NULL,
    id_unidade VARCHAR2(5) NOT NULL
);

ALTER TABLE unidade_aluno ADD CONSTRAINT unidade_aluno_pk PRIMARY KEY ( matricula,
                                                                        id_unidade );

ALTER TABLE bolsa
    ADD CONSTRAINT bolsa_bolsista_fk FOREIGN KEY ( id_discente )
        REFERENCES bolsista ( id_discente );

ALTER TABLE bolsa
    ADD CONSTRAINT bolsa_pesquisa_fk FOREIGN KEY ( id_pesquisa )
        REFERENCES pesquisa ( id_pesquisa );

ALTER TABLE bolsa
    ADD CONSTRAINT bolsa_unidade_fk FOREIGN KEY ( id_unidade )
        REFERENCES unidade ( id_unidade );

ALTER TABLE bolsista
    ADD CONSTRAINT bolsista_aluno_fk FOREIGN KEY ( matricula )
        REFERENCES aluno ( matricula );

ALTER TABLE bolsista
    ADD CONSTRAINT bolsista_grupo_pesquisa_fk FOREIGN KEY ( id_grupo )
        REFERENCES grupo_pesquisa ( id_grupo );

ALTER TABLE bolsista
    ADD CONSTRAINT bolsista_orientador_fk FOREIGN KEY ( id_orientador )
        REFERENCES orientador ( id_orientador );

ALTER TABLE projeto_pesquisa
    ADD CONSTRAINT categoria_fk FOREIGN KEY ( cd_categoria )
        REFERENCES categoria_pesquisa ( cd_categoria );

ALTER TABLE unidade_aluno
    ADD CONSTRAINT id_unidade_fk FOREIGN KEY ( id_unidade )
        REFERENCES unidade ( id_unidade );

ALTER TABLE unidade_aluno
    ADD CONSTRAINT matricula_aluno_fk FOREIGN KEY ( matricula )
        REFERENCES aluno ( matricula );

ALTER TABLE orientador
    ADD CONSTRAINT orientador_grupo_pesquisa_fk FOREIGN KEY ( id_grupo )
        REFERENCES grupo_pesquisa ( id_grupo );

ALTER TABLE projeto_pesquisa
    ADD CONSTRAINT pesquisa_fk FOREIGN KEY ( id_pesquisa )
        REFERENCES pesquisa ( id_pesquisa );

ALTER TABLE projeto_pesquisa
    ADD CONSTRAINT projeto_fk FOREIGN KEY ( codigo_projeto )
        REFERENCES projeto ( codigo_projeto );
