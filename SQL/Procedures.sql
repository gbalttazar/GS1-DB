--T_AUTORIDADE_AMBIENTAL
-- Cria��o do procedimento log_autoridade_ambiental
CREATE OR REPLACE PROCEDURE log_autoridade_ambiental(
    p_ds_autoridade_ambiental IN VARCHAR2,
    p_nm_autoridade_ambiental IN VARCHAR2
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    BEGIN
        -- Valida��o para garantir que o nome da autoridade ambiental n�o contenha caracteres especiais
        IF REGEXP_LIKE(p_nm_autoridade_ambiental, '[^a-zA-Z0-9 ]') THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_autoridade_ambiental', USER, SYSTIMESTAMP, -20001, 'O nome da autoridade ambiental n�o deve conter caracteres especiais.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20001, 'O nome da autoridade ambiental n�o deve conter caracteres especiais.');
        END IF;

        -- Valida��o para garantir que a descri��o da autoridade ambiental n�o exceda 100 caracteres
        IF LENGTH(p_ds_autoridade_ambiental) > 100 THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_autoridade_ambiental', USER, SYSTIMESTAMP, -20002, 'A descri��o da autoridade ambiental n�o pode conter mais de 100 caracteres.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o da autoridade ambiental n�o pode conter mais de 100 caracteres.');
        END IF;
    END; -- Fim do bloco de valida��o de entrada

    -- Bloco para inser��o na tabela t_autoridade_ambiental
    BEGIN
        INSERT INTO t_autoridade_ambiental (id_autoridade_ambiental, ds_autoridade_ambiental, nm_autoridade_ambiental)
        VALUES (SQ_t_autoridade_ambiental.NEXTVAL, p_ds_autoridade_ambiental, p_nm_autoridade_ambiental);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_autoridade_ambiental', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END; -- Fim do bloco de inser��o
END log_autoridade_ambiental;
/

-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_autoridade_ambiental(
        p_ds_autoridade_ambiental => 'Descricao Valida da Autoridade Ambiental',
        p_nm_autoridade_ambiental => 'NomeValidoAutoridade'
    );
END;
/
-- Exemplo de Chamada para Gerar um Erro de Nome com Caracteres Especiais
BEGIN
    log_autoridade_ambiental(
        p_ds_autoridade_ambiental => 'Descricao Valida da Autoridade Ambiental',
        p_nm_autoridade_ambiental => 'Nome@Invalido!'
    );
END;
/
-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_autoridade_ambiental(
        p_ds_autoridade_ambiental => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_nm_autoridade_ambiental => 'NomeValidoAutoridade'
    );
END;
/

-- Verificar os registros na tabela de autoridades ambientais
SELECT * FROM t_autoridade_ambiental;

SELECT * FROM t_log_erros;
---------------------------------------------------------------------------------------------
--T_EMAIL

-- Cria��o do procedimento log_email
CREATE OR REPLACE PROCEDURE log_email(
    p_ds_email IN VARCHAR2,
    p_tp_email IN VARCHAR2,
    p_st_email IN CHAR
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    -- Valida��o para garantir que o tipo do email n�o contenha caracteres especiais
    IF REGEXP_LIKE(p_tp_email, '[^a-zA-Z0-9 ]') THEN
        -- Registro do erro na tabela t_log_erros
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_email', USER, SYSTIMESTAMP, -20001, 'O tipo do email n�o deve conter caracteres especiais.');
        -- Commit para garantir que o log seja salvo
        COMMIT;
        -- Relevanta o erro para n�o mascar�-lo
        RAISE_APPLICATION_ERROR(-20001, 'O tipo do email n�o deve conter caracteres especiais.');
    END IF;

    -- Valida��o para garantir que a descri��o do email tenha menos de 100 caracteres
    IF LENGTH(p_ds_email) > 100 THEN
        -- Registro do erro na tabela t_log_erros
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_email', USER, SYSTIMESTAMP, -20002, 'A descri��o do email deve conter menos de 100 caracteres.');
        -- Commit para garantir que o log seja salvo
        COMMIT;
        -- Relevanta o erro para n�o mascar�-lo
        RAISE_APPLICATION_ERROR(-20002, 'A descri��o do email deve conter menos de 100 caracteres.');
    END IF;

    -- Bloco para inser��o na tabela t_email
    BEGIN
        INSERT INTO t_email (id_email, ds_email, tp_email, st_email)
        VALUES (SQ_t_email.NEXTVAL, p_ds_email, p_tp_email, p_st_email);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_email', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END;
END log_email;
/

-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_email(
        p_ds_email => 'Email valido.',
        p_tp_email => 'TipoValidoEmail',
        p_st_email => 'A'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Tipo de Email com Caracteres Especiais
BEGIN
    log_email(
        p_ds_email => 'Email valido.',
        p_tp_email => 'Tipo@Invalido!',
        p_st_email => 'A'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_email(
        p_ds_email => 'Esta descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa e n�o atende aos crit�rios.',
        p_tp_email => 'TipoValidoEmail',
        p_st_email => 'A'
    );
END;
/

-- Verificar os registros na tabela de emails
SELECT * FROM t_email;

SELECT * FROM t_log_erros;
----------------------------------------------------------------------------------------------------------
--T_USUARIO
CREATE OR REPLACE PROCEDURE log_usuario(
    p_ds_usuario IN VARCHAR2,
    p_nm_usuario IN VARCHAR2,
    p_senha_usuario IN VARCHAR2,
    p_id_email IN NUMBER
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    BEGIN
        -- Valida��o para garantir que o nome do usu�rio n�o contenha caracteres especiais
        IF REGEXP_LIKE(p_nm_usuario, '[^a-zA-Z0-9 ]') THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_usuario', USER, SYSTIMESTAMP, -20001, 'O nome do usu�rio n�o deve conter caracteres especiais.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20001, 'O nome do usu�rio n�o deve conter caracteres especiais.');
        END IF;

        -- Valida��o para garantir que a descri��o do usu�rio n�o exceda 100 caracteres
        IF LENGTH(p_ds_usuario) > 100 THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_usuario', USER, SYSTIMESTAMP, -20002, 'A descri��o do usu�rio n�o pode conter mais de 100 caracteres.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o do usu�rio n�o pode conter mais de 100 caracteres.');
        END IF;
    END; -- Fim do bloco de valida��o de entrada

    -- Bloco para inser��o na tabela t_usuario
    BEGIN
        INSERT INTO t_usuario (id_usuario, id_email, ds_usuario, nm_usuario, senha_usuario)
        VALUES (SQ_t_usuario.NEXTVAL, p_id_email, p_ds_usuario, p_nm_usuario, p_senha_usuario);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_usuario', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END; -- Fim do bloco de inser��o
END log_usuario;
/



-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_usuario(
        p_ds_usuario => 'Descricao Valida do Usuario',
        p_nm_usuario => 'NomeValidoUsuario',
        p_senha_usuario => 'SenhaValida',
        p_id_email => 1
    );
END;
/


BEGIN
    log_usuario(
        p_ds_usuario => 'Descricao Valida do Usuario',
        p_nm_usuario => 'Nome@Invalido!',
        p_senha_usuario => 'SenhaValida',
        p_id_email => 1
    );
END;
/

BEGIN
    log_usuario(
        p_ds_usuario => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_nm_usuario => 'NomeValidoUsuario',
        p_senha_usuario => 'SenhaValida',
        p_id_email => 1
    );
END;
/

-- Verificar os registros na tabela de usu�rios
SELECT * FROM t_usuario;
SELECT * FROM t_log_erros;



-----------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_aplicativo(
    p_nm_aplicativo IN VARCHAR2,
    p_ds_aplicativo IN VARCHAR2,
    p_st_aplicativo IN VARCHAR2,
    p_id_usuario IN NUMBER
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    BEGIN
        -- Valida��o para garantir que o nome do aplicativo n�o contenha caracteres especiais
        IF REGEXP_LIKE(p_nm_aplicativo, '[^a-zA-Z0-9 ]') THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_aplicativo', USER, SYSTIMESTAMP, -20001, 'O nome do aplicativo n�o deve conter caracteres especiais.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20001, 'O nome do aplicativo n�o deve conter caracteres especiais.');
        END IF;

        -- Valida��o para garantir que a descri��o do aplicativo n�o exceda 100 caracteres
        IF LENGTH(p_ds_aplicativo) > 100 THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_aplicativo', USER, SYSTIMESTAMP, -20002, 'A descri��o do aplicativo n�o pode conter mais de 100 caracteres.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o do aplicativo n�o pode conter mais de 100 caracteres.');
        END IF;
    END; -- Fim do bloco de valida��o de entrada

    -- Bloco para inser��o na tabela t_aplicativo
    BEGIN
        INSERT INTO t_aplicativo (id_aplicativo, nm_aplicativo, ds_aplicativo, st_aplicativo, id_usuario)
        VALUES (SQ_t_aplicativo.NEXTVAL, p_nm_aplicativo, p_ds_aplicativo, p_st_aplicativo, p_id_usuario);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_aplicativo', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END; -- Fim do bloco de inser��o
END log_aplicativo;
/

-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_aplicativo(
        p_nm_aplicativo => 'NomeValidoAplicativo',
        p_ds_aplicativo => 'Descricao Valida do Aplicativo',
        p_st_aplicativo => 'I', -- Ajustado para 1 caractere
        p_id_usuario => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Nome com Caracteres Especiais
BEGIN
    log_aplicativo(
        p_nm_aplicativo => 'Nome@Invalido!',
        p_ds_aplicativo => 'Descricao Valida do Aplicativo',
        p_st_aplicativo => 'I', -- Ajustado para 1 caractere
        p_id_usuario => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_aplicativo(
        p_nm_aplicativo => 'NomeValidoAplicativo',
        p_ds_aplicativo => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_st_aplicativo => 'I', -- Ajustado para 1 caractere
        p_id_usuario => 1
    );
END;
/

-- Verificar os registros na tabela de aplicativos
SELECT * FROM t_aplicativo;

-- Verificar os registros na tabela de logs de erros
SELECT * FROM t_log_erros;

-----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_localizacao(
    p_latitude IN VARCHAR2,
    p_longitude IN VARCHAR2,
    p_ds_localizacao IN VARCHAR2
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    BEGIN
        -- Valida��o para garantir que a latitude tenha mais de 1 caractere
        IF LENGTH(p_latitude) <= 1 THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_localizacao', USER, SYSTIMESTAMP, -20001, 'A latitude deve ter mais de 1 caractere.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20001, 'A latitude deve ter mais de 1 caractere.');
        END IF;

        -- Valida��o para garantir que a descri��o da localiza��o n�o contenha n�meros
        IF REGEXP_LIKE(p_ds_localizacao, '[0-9]') THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_localizacao', USER, SYSTIMESTAMP, -20002, 'A descri��o da localiza��o n�o pode conter n�meros.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o da localiza��o n�o pode conter n�meros.');
        END IF;
    END; -- Fim do bloco de valida��o de entrada

    -- Bloco para inser��o na tabela t_localizacao
    BEGIN
        INSERT INTO t_localizacao (id_localizacao, latitude, longitude, ds_localizacao)
        VALUES (SQ_t_localizacao.NEXTVAL, p_latitude, p_longitude, p_ds_localizacao);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_localizacao', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END; -- Fim do bloco de inser��o
END log_localizacao;
/
-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_localizacao(
        p_latitude => '45.12345',
        p_longitude => '90.12345',
        p_ds_localizacao => 'DescricaoValida'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Latitude com Menos de 1 Caractere
BEGIN
    log_localizacao(
        p_latitude => '4',
        p_longitude => '90.12345',
        p_ds_localizacao => 'DescricaoValida'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com N�meros
BEGIN
    log_localizacao(
        p_latitude => '45.12345',
        p_longitude => '90.12345',
        p_ds_localizacao => 'Descricao123'
    );
END;
/

-- Verificar os registros na tabela de localiza��es
SELECT * FROM t_localizacao;

-- Verificar os registros na tabela de logs de erros
SELECT * FROM t_log_erros;

-------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_sistema(
    p_st_sistema IN CHAR,
    p_ds_sistema IN VARCHAR2,
    p_tp_sistema IN VARCHAR2,
    p_id_residuos IN NUMBER
)
AS
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Validation block
    BEGIN
        -- Validation to ensure that the system type does not contain special characters
        IF REGEXP_LIKE(p_tp_sistema, '[^a-zA-Z0-9 ]') THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_sistema', USER, SYSTIMESTAMP, -20001, 'O tipo do sistema n�o deve conter caracteres especiais.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20001, 'O tipo do sistema n�o deve conter caracteres especiais.');
        END IF;

        -- Validation to ensure that the system description does not exceed 100 characters
        IF LENGTH(p_ds_sistema) > 100 THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_sistema', USER, SYSTIMESTAMP, -20002, 'A descri��o do sistema n�o pode conter mais de 100 caracteres.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o do sistema n�o pode conter mais de 100 caracteres.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_sistema', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;

    -- Insertion block into t_sistema table
    BEGIN
        -- Insert into t_sistema table
        INSERT INTO t_sistema (id_sistema, st_sistema, ds_sistema, tp_sistema, id_residuos)
        VALUES (SQ_t_sistema.NEXTVAL, p_st_sistema, p_ds_sistema, p_tp_sistema, p_id_residuos);

        -- Log the successful operation in t_log_erros table
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_sistema', USER, SYSTIMESTAMP, -2080, 'Sistema Inv�lido');

        COMMIT; -- Explicit commit
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_sistema', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;
END log_sistema;
/

-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_sistema(
        p_st_sistema => 'A',
        p_ds_sistema => 'Descricao Valida do Sistema',
        p_tp_sistema => 'TipoValidoSistema',
        p_id_residuos => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Tipo de Sistema com Caracteres Especiais
BEGIN
    log_sistema(
        p_st_sistema => 'A',
        p_ds_sistema => 'Descricao Valida do Sistema',
        p_tp_sistema => 'Tipo@Invalido!',
        p_id_residuos => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_sistema(
        p_st_sistema => 'A',
        p_ds_sistema => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_tp_sistema => 'TipoValido',
        p_id_residuos => 1
    );
END;
/

-- Verificar os registros na tabela de sistemas
SELECT * FROM t_sistema;

-- Verificar os registros na tabela de logs de erros
SELECT * FROM t_log_erros;
--------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_residuos(
    p_ds_residuos IN VARCHAR2,
    p_tp_residuos IN VARCHAR2
)
AS
    -- Declara��o de vari�veis para captura de erros personalizados
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Bloco para valida��o de entrada
    BEGIN
        -- Valida��o para garantir que o tipo de res�duos n�o contenha caracteres especiais
        IF REGEXP_LIKE(p_tp_residuos, '[^a-zA-Z0-9 ]') THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_residuos', USER, SYSTIMESTAMP, -20001, 'O tipo do res�duo n�o deve conter caracteres especiais.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20001, 'O tipo do res�duo n�o deve conter caracteres especiais.');
        END IF;

        -- Valida��o para garantir que a descri��o do res�duo n�o exceda 100 caracteres
        IF LENGTH(p_ds_residuos) > 100 THEN
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_residuos', USER, SYSTIMESTAMP, -20002, 'A descri��o do res�duo n�o pode conter mais de 100 caracteres.');
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o do res�duo n�o pode conter mais de 100 caracteres.');
        END IF;
    END; -- Fim do bloco de valida��o de entrada

    -- Bloco para inser��o na tabela t_residuos
    BEGIN
        INSERT INTO t_residuos (id_residuos, ds_residuos, tp_residuos)
        VALUES (SQ_t_residuos.NEXTVAL, p_ds_residuos, p_tp_residuos);

        COMMIT; -- Commit expl�cito
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura c�digo e mensagem de erro
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Registro do erro na tabela t_log_erros
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_residuos', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Commit para garantir que o log seja salvo
            COMMIT;
            -- Relevanta o erro para n�o mascar�-lo
            RAISE;
    END; -- Fim do bloco de inser��o
END log_residuos;
/
-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_residuos(
        p_ds_residuos => 'Descri��o v�lida do res�duo.',
        p_tp_residuos => 'TipoValidoResiduo'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Tipo de Res�duo com Caracteres Especiais
BEGIN
    log_residuos(
        p_ds_residuos => 'Descri��o v�lida do res�duo.',
        p_tp_residuos => 'Tipo@Invalido!'
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_residuos(
        p_ds_residuos => 'Esta descri��o excede o limite de cem caracteres. Esta descri��o deveria causar um erro porque � muito longa e n�o atende aos crit�rios.',
        p_tp_residuos => 'TipoValidoResiduo'
    );
END;
/

-- Verificar os registros na tabela de res�duos
SELECT * FROM t_residuos;

-- Verificar os registros na tabela de logs de erros
SELECT * FROM t_log_erros;

---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_comentario(
    p_ds_comentario IN VARCHAR2,
    p_tp_comentario IN VARCHAR2,
    p_id_sistema IN NUMBER
)
AS
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Validation block
    BEGIN
        -- Validation to ensure that the comment type does not contain special characters
        IF REGEXP_LIKE(p_tp_comentario, '[^a-zA-Z0-9 ]') THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_comentario', USER, SYSTIMESTAMP, -20001, 'O tipo do coment�rio n�o deve conter caracteres especiais.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20001, 'O tipo do coment�rio n�o deve conter caracteres especiais.');
        END IF;

        -- Validation to ensure that the comment description does not exceed 100 characters
        IF LENGTH(p_ds_comentario) > 100 THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_comentario', USER, SYSTIMESTAMP, -20002, 'A descri��o do coment�rio n�o pode conter mais de 100 caracteres.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o do coment�rio n�o pode conter mais de 100 caracteres.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_comentario', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;

    -- Insertion block into t_comentario table
    BEGIN
        -- Insert into t_comentario table
        INSERT INTO t_comentario (id_comentario, id_sistema, ds_comentario, tp_comentario)
        VALUES (SQ_t_comentario.NEXTVAL, p_id_sistema, p_ds_comentario, p_tp_comentario);

        -- Log the successful operation in t_log_erros table
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_comentario', USER, SYSTIMESTAMP, -2080, 'Coment�rio Inv�lido.');

        COMMIT; -- Explicit commit
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_comentario', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;
END log_comentario;
/

-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_comentario(
        p_ds_comentario => 'Comentario v�lido.',
        p_tp_comentario => 'TipoValidoComentario',
        p_id_sistema => 123
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Tipo de Coment�rio com Caracteres Especiais
BEGIN
    log_comentario(
        p_ds_comentario => 'Comentario v�lido.',
        p_tp_comentario => 'Tipo@Invalido!',
        p_id_sistema => 123
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_comentario(
        p_ds_comentario => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_tp_comentario => 'TipoValidoComentario',
        p_id_sistema => 123
    );
END;
/

-- Verificar os registros na tabela de coment�rios
SELECT * FROM t_comentario;

-- Verificar os registros na tabela de logs de erros
SELECT * FROM t_log_erros;

--------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE log_notificacao(
    p_ds_notificacao IN VARCHAR2,
    p_st_notificacao IN CHAR,
    p_tp_notificacao IN VARCHAR2,
    p_id_autoridade_ambiental IN NUMBER,
    p_id_comentario IN NUMBER
)
AS
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Validation block
    BEGIN
        -- Validation to ensure that the notification type does not contain special characters
        IF REGEXP_LIKE(p_tp_notificacao, '[^a-zA-Z0-9 ]') THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_notificacao', USER, SYSTIMESTAMP, -20001, 'O tipo da notifica��o n�o deve conter caracteres especiais.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20001, 'O tipo da notifica��o n�o deve conter caracteres especiais.');
        END IF;

        -- Validation to ensure that the notification description does not exceed 100 characters
        IF LENGTH(p_ds_notificacao) > 100 THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_notificacao', USER, SYSTIMESTAMP, -20002, 'A descri��o da notifica��o n�o pode conter mais de 100 caracteres.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o da notifica��o n�o pode conter mais de 100 caracteres.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_notificacao', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;

    -- Insertion block into t_notificacao table
    BEGIN
        -- Insert into t_notificacao table
        INSERT INTO t_notificacao (id_notificacao, ds_notificacao, st_notificacao, tp_notificacao, id_autoridade_ambiental, id_comentario)
        VALUES (SQ_t_notificacao.NEXTVAL, p_ds_notificacao, p_st_notificacao, p_tp_notificacao, p_id_autoridade_ambiental, p_id_comentario);

        -- Log the successful operation in t_log_erros table
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_notificacao', USER, SYSTIMESTAMP, -2080, 'Notifica��o Inv�lido.');

        COMMIT; -- Explicit commit
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_notificacao', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Rollback
            ROLLBACK;
            -- Raise the error to avoid masking it
            RAISE;
    END;
END log_notificacao;
/


-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_notificacao(
        p_ds_notificacao => 'Descricao Valida da Notificacao',
        p_st_notificacao => 'A',
        p_tp_notificacao => 'TipoValido',
        p_id_autoridade_ambiental => 1,
        p_id_comentario => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Tipo com Caracteres Especiais
BEGIN
    log_notificacao(
        p_ds_notificacao => 'Descricao Valida da Notificacao',
        p_st_notificacao => 'A',
        p_tp_notificacao => 'Tipo@Invalido!',
        p_id_autoridade_ambiental => 1,
        p_id_comentario => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_notificacao(
        p_ds_notificacao => 'Descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa.',
        p_st_notificacao => 'A',
        p_tp_notificacao => 'TipoValido',
        p_id_autoridade_ambiental => 1,
        p_id_comentario => 1
    );
END;
/

-- Verificar os registros na tabela de notifica��es
SELECT * FROM t_notificacao;
SELECT * FROM t_log_erros;

--------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE log_denuncia(
    p_ds_denuncia IN VARCHAR2,
    p_dt_ocorrencia IN DATE,
    p_st_denuncia IN CHAR,
    p_loc_denuncia IN VARCHAR2,
    p_id_localizacao IN NUMBER, 
    p_id_usuario IN NUMBER,
    p_id_autoridade_ambiental IN NUMBER,
    p_id_notificacao IN NUMBER
)
AS
    v_err_code NUMBER;
    v_err_msg VARCHAR2(4000);
BEGIN
    -- Validation block
    BEGIN
        -- Validation to ensure that the location of the denunciation does not contain special characters
        IF REGEXP_LIKE(p_loc_denuncia, '[^a-zA-Z0-9 ]') THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_denuncia', USER, SYSTIMESTAMP, -20001, 'O Local da den�ncia n�o deve conter caracteres especiais.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20001, 'O Local da den�ncia n�o deve conter caracteres especiais.');
        END IF;

        -- Validation to ensure that the description of the denunciation has less than 100 characters
        IF LENGTH(p_ds_denuncia) >= 100 THEN
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_denuncia', USER, SYSTIMESTAMP, -20002, 'A descri��o da den�ncia deve conter menos de 100 caracteres.');
            -- Raise the error to avoid masking it
            RAISE_APPLICATION_ERROR(-20002, 'A descri��o da den�ncia deve conter menos de 100 caracteres.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_denuncia', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Raise the error to avoid masking it
            RAISE;
    END;

    -- Insertion block into t_denuncia table
    BEGIN
        INSERT INTO t_denuncia (id_denuncia, ds_denuncia, dt_ocorrencia, st_denuncia, loc_denuncia, id_localizacao, id_usuario, id_autoridade_ambiental, id_notificacao)
        VALUES (SQ_t_denuncia.NEXTVAL, p_ds_denuncia, p_dt_ocorrencia, p_st_denuncia, p_loc_denuncia, p_id_localizacao, p_id_usuario, p_id_autoridade_ambiental, p_id_notificacao);

        -- Log the successful operation in t_log_erros table
        INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
        VALUES ('log_denuncia', USER, SYSTIMESTAMP, -2080, 'Den�ncia Inv�lida.');

        COMMIT; -- Explicit commit
    EXCEPTION
        WHEN OTHERS THEN
            -- Capture error code and message
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            -- Log the error in t_log_erros table
            INSERT INTO t_log_erros (nm_procedure, nm_user_log, dt_ocor_erro, cdg_erro, msg_erro)
            VALUES ('log_denuncia', USER, SYSTIMESTAMP, v_err_code, v_err_msg);
            -- Raise the error to avoid masking it
            RAISE;
    END;
END log_denuncia;
/
-- Exemplo de Chamada com Par�metros V�lidos
BEGIN
    log_denuncia(
        p_ds_denuncia => 'Denuncia valida.',
        p_dt_ocorrencia => TO_DATE('2024-06-05', 'YYYY-MM-DD'),
        p_st_denuncia => 'A',
        p_loc_denuncia => 'Local Valido',
        p_id_localizacao => 1,
        p_id_usuario => 1,
        p_id_autoridade_ambiental => 1,
        p_id_notificacao => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Local com Caracteres Especiais
BEGIN
    log_denuncia(
        p_ds_denuncia => 'Denuncia valida.',
        p_dt_ocorrencia => TO_DATE('2024-06-05', 'YYYY-MM-DD'),
        p_st_denuncia => 'A',
        p_loc_denuncia => 'Local@Invalido!',
        p_id_localizacao => 1,
        p_id_usuario => 1,
        p_id_autoridade_ambiental => 1,
        p_id_notificacao => 1
    );
END;
/

-- Exemplo de Chamada para Gerar um Erro de Descri��o com Mais de 100 Caracteres
BEGIN
    log_denuncia(
        p_ds_denuncia => 'Esta descricao que excede o limite de cem caracteres. Esta descricao deveria causar um erro porque � muito longa e n�o atende aos crit�rios.',
        p_dt_ocorrencia => TO_DATE('2024-06-05', 'YYYY-MM-DD'),
        p_st_denuncia => 'A',
        p_loc_denuncia => 'Local Valido',
        p_id_localizacao => 1,
        p_id_usuario => 1,
        p_id_autoridade_ambiental => 1,
        p_id_notificacao => 1
    );
END;
/



-- Verificar os registros na tabela de den�ncias
SELECT * FROM t_denuncia;

SELECT * FROM t_log_erros;


---------------------------------------------------------------------------------------------------------------------------
  


SELECT * FROM t_log_erros;