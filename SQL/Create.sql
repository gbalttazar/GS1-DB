-- Corrected table creation and comments

-- Sequence creation
CREATE SEQUENCE SQ_T_APLICATIVO;
CREATE SEQUENCE SQ_T_AUTORIDADE_AMBIENTAL;
CREATE SEQUENCE SQ_T_COMENTARIO;
CREATE SEQUENCE SQ_T_DENUNCIA;
CREATE SEQUENCE SQ_T_EMAIL;
CREATE SEQUENCE SQ_T_LOCALIZACAO;
CREATE SEQUENCE SQ_T_NOTIFICACAO;
CREATE SEQUENCE SQ_T_RESIDUOS;
CREATE SEQUENCE SQ_T_SISTEMA;
CREATE SEQUENCE SQ_T_USUARIO;
CREATE SEQUENCE SQ_t_log_erros;


-- Table creation
CREATE TABLE t_aplicativo (
    id_aplicativo NUMBER(9) NOT NULL,
    id_usuario    NUMBER(9) NOT NULL,
    nm_aplicativo VARCHAR2(100) NOT NULL,
    ds_aplicativo VARCHAR2(100) NOT NULL,
    st_aplicativo CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_aplicativo.id_aplicativo IS
    'Esse atributo irá receber a chave primária do Aplicativo. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_aplicativo.nm_aplicativo IS
    'Esse atributo irá receber o nome do aplicativo. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_aplicativo.ds_aplicativo IS
    'Esse atributo irá receber a descrição do aplicativo. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_aplicativo.st_aplicativo IS
    'Esse atributo irá receber o status do aplicativo. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_aplicativo__idx ON t_aplicativo (id_usuario ASC);

ALTER TABLE t_aplicativo ADD CONSTRAINT t_aplicativo_pk PRIMARY KEY (id_aplicativo);

-- Other table creation
CREATE TABLE t_autoridade_ambiental (
    id_autoridade_ambiental NUMBER(9) NOT NULL,
    ds_autoridade_ambiental VARCHAR2(100) NOT NULL,
    nm_autoridade_ambiental VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN t_autoridade_ambiental.id_autoridade_ambiental IS
    'Esse atributo irá receber a chave primária do Autoridade Ambiental. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_autoridade_ambiental.ds_autoridade_ambiental IS
    'Esse atributo irá receber a descrição da autoridade ambiental. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_autoridade_ambiental.nm_autoridade_ambiental IS
    'Esse atributo irá receber o nome da autoridade ambiental. Seu conteúdo é obrigatório.';

ALTER TABLE t_autoridade_ambiental ADD CONSTRAINT t_autoridade_ambiental_pk PRIMARY KEY (id_autoridade_ambiental);

CREATE TABLE t_comentario (
    id_comentario NUMBER(9) NOT NULL,
    ds_comentario VARCHAR2(100) NOT NULL,
    tp_comentario VARCHAR2(100) NOT NULL,
    id_sistema    NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_comentario.id_comentario IS
    'Esse atributo irá receber a chave primária do Comentário. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_comentario.ds_comentario IS
    'Esse atributo irá receber a descrição do comentario. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_comentario.tp_comentario IS
    'Esse atributo irá receber o tipo do comentario. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_comentario__idx ON t_comentario (id_sistema ASC);

ALTER TABLE t_comentario ADD CONSTRAINT t_comentario_pk PRIMARY KEY (id_comentario);

-- Continue with other tables in similar fashion

CREATE TABLE t_denuncia (
    id_denuncia             NUMBER(9) NOT NULL,
    ds_denuncia             VARCHAR2(100) NOT NULL,
    dt_ocorrencia           DATE NOT NULL,
    st_denuncia             CHAR(1) NOT NULL,
    loc_denuncia            VARCHAR2(80) NOT NULL,
    id_localizacao          NUMBER(9) NOT NULL,
    id_usuario              NUMBER(9) NOT NULL,
    id_autoridade_ambiental NUMBER(9) NOT NULL,
    id_notificacao          NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_denuncia.id_denuncia IS
    'Esse atributo irá receber a chave primária da Denuncia. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_denuncia.ds_denuncia IS
    'Esse atributo irá receber a descrição da denuncia. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_denuncia.dt_ocorrencia IS
    'Esse atributo irá receber a data da ocorrencia da denuncia. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_denuncia.st_denuncia IS
    'Esse atributo irá receber o status da denuncia. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_denuncia.loc_denuncia IS
    'Esse atributo irá receber a localização da denuncia. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_denuncia__idx ON t_denuncia (id_localizacao ASC);
CREATE UNIQUE INDEX t_denuncia__idxv1 ON t_denuncia (id_usuario ASC);
CREATE UNIQUE INDEX t_denuncia__idxv2 ON t_denuncia (id_autoridade_ambiental ASC);
CREATE UNIQUE INDEX t_denuncia__idxv3 ON t_denuncia (id_notificacao ASC);

ALTER TABLE t_denuncia ADD CONSTRAINT t_denuncia_pk PRIMARY KEY (id_denuncia);

CREATE TABLE t_email (
    id_email NUMBER(9) NOT NULL,
    st_email CHAR(1) NOT NULL,
    tp_email VARCHAR2(100) NOT NULL,
    ds_email VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN t_email.id_email IS
    'Esse atributo irá receber a chave primária do Email. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_email.st_email IS
    'Esse atributo irá receber o status do email. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_email.tp_email IS
    'Esse atributo irá receber o tipo do email. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_email.ds_email IS
    'Esse atributo irá receber a descrição do email. Seu conteúdo é obrigatório.';

ALTER TABLE t_email ADD CONSTRAINT t_email_pk PRIMARY KEY (id_email);

CREATE TABLE t_localizacao (
    id_localizacao NUMBER(9) NOT NULL,
    latitude       VARCHAR2(100) NOT NULL,
    longitude      VARCHAR2(100) NOT NULL,
    ds_localizacao VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN t_localizacao.id_localizacao IS
    'Esse atributo irá receber a chave primária da Localização. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_localizacao.latitude IS
    'Esse atributo irá receber a latitude da localização. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_localizacao.longitude IS
    'Esse atributo irá receber a longitude da localização. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_localizacao.ds_localizacao IS
    'Esse atributo irá receber a descrição da localização. Seu conteúdo é obrigatório.';

ALTER TABLE t_localizacao ADD CONSTRAINT t_localizacao_pk PRIMARY KEY (id_localizacao);

CREATE TABLE t_notificacao (
    id_notificacao          NUMBER(9) NOT NULL,
    ds_notificacao          VARCHAR2(100) NOT NULL,
    st_notificacao          CHAR(1) NOT NULL,
    tp_notificacao          VARCHAR2(100) NOT NULL,
    id_autoridade_ambiental NUMBER(9) NOT NULL,
    id_comentario           NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_notificacao.id_notificacao IS
    'Esse atributo irá receber a chave primária da Notificação. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_notificacao.ds_notificacao IS
    'Esse atributo irá receber a descrição da notificação. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_notificacao.st_notificacao IS
    'Esse atributo irá receber o status da notificação. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_notificacao.tp_notificacao IS
    'Esse atributo irá receber o tipo da notificação. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_notificacao__idx ON t_notificacao (id_comentario ASC);

ALTER TABLE t_notificacao ADD CONSTRAINT t_notificacao_pk PRIMARY KEY (id_notificacao);

CREATE TABLE t_residuos (
    id_residuos NUMBER(9) NOT NULL,
    tp_residuos VARCHAR2(100) NOT NULL,
    ds_residuos VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN t_residuos.id_residuos IS
    'Esse atributo irá receber a chave primária do Residuos. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_residuos.tp_residuos IS
    'Esse atributo irá receber tipo dos residuos. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_residuos.ds_residuos IS
    'Esse atributo irá receber a descrição dos residuos. Seu conteúdo é obrigatório.';

ALTER TABLE t_residuos ADD CONSTRAINT t_residuos_pk PRIMARY KEY (id_residuos);

CREATE TABLE t_sistema (
    id_sistema  NUMBER(9) NOT NULL,
    st_sistema  CHAR(1) NOT NULL,
    ds_sistema  VARCHAR2(100) NOT NULL,
    tp_sistema  VARCHAR2(100) NOT NULL,
    id_residuos NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_sistema.id_sistema IS
    'Esse atributo irá receber a chave primária do Sistema. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN t_sistema.st_sistema IS
    'Esse atributo irá receber o status do sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_sistema.ds_sistema IS
    'Esse atributo irá receber a descrição do sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_sistema.tp_sistema IS
    'Esse atributo irá receber tipo do sistema. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_sistema__idx ON
    t_sistema (
        id_residuos
    ASC );

ALTER TABLE t_sistema ADD CONSTRAINT t_sistema_pk PRIMARY KEY ( id_sistema );

CREATE TABLE t_usuario (
    id_usuario    NUMBER(9) NOT NULL,
    ds_usuario    VARCHAR2(100) NOT NULL,
    nm_usuario    VARCHAR2(100) NOT NULL,
    senha_usuario VARCHAR2(60) NOT NULL,
    id_email      NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_usuario.id_usuario IS
    'Esse atributo irá receber a chave primária do Usuario. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN t_usuario.ds_usuario IS
    'Esse atributo irá receber a descrição da usuario. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_usuario.nm_usuario IS
    'Esse atributo irá receber o nome do usuario. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_usuario.senha_usuario IS
    'Esse atributo irá receber a senha de acesso ao aplicativo do usuario. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX t_usuario__idx ON
    t_usuario (
        id_email
    ASC );

CREATE TABLE t_log_erros (
    id_log_erro NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nm_procedure VARCHAR2(100),
    nm_user_log VARCHAR2(100),
    dt_ocor_erro TIMESTAMP,
    cdg_erro NUMBER,
    msg_erro VARCHAR2(4000),
    CONSTRAINT pk_log_erros PRIMARY KEY (id_log_erro)
);

ALTER TABLE t_usuario ADD CONSTRAINT t_usuario_pk PRIMARY KEY ( id_usuario );