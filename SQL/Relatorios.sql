set serveroutput on
set verify off


BEGIN
  DBMS_OUTPUT.PUT_LINE('Teste de sa�da DBMS_OUTPUT');
END;
/

-- Bloco An�nimo 1: Listar Todos os Dados da Tabela t_sistema
-- Cursor Expl�cito: O cursor cur_all_data � declarado e utilizado explicitamente.
-- Tomada de Decis�o: A instru��o EXIT WHEN cur_all_data%NOTFOUND � utilizada para sair do loop quando n�o houver mais registros.
DECLARE
  CURSOR cur_all_data IS
    SELECT id_sistema, st_sistema, ds_sistema, tp_sistema, id_residuos FROM t_sistema;
  v_id_sistema t_sistema.id_sistema%TYPE;
  v_st_sistema t_sistema.st_sistema%TYPE;
  v_ds_sistema t_sistema.ds_sistema%TYPE;
  v_tp_sistema t_sistema.tp_sistema%TYPE;
  v_id_residuos t_sistema.id_residuos%TYPE;
BEGIN
  OPEN cur_all_data;
  LOOP
    FETCH cur_all_data INTO v_id_sistema, v_st_sistema, v_ds_sistema, v_tp_sistema, v_id_residuos;
    EXIT WHEN cur_all_data%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_id_sistema || ' ' || v_st_sistema || ' ' || v_ds_sistema || ' ' || v_tp_sistema || ' ' || v_id_residuos);
  END LOOP;
  CLOSE cur_all_data;
END;
/


-- Bloco An�nimo 2: Mostrar Dados Num�ricos Sumarizados da Tabela t_sistema
-- Cursor Expl�cito: O cursor cur_sum � declarado e utilizado explicitamente.
-- Tomada de Decis�o: A instru��o EXIT WHEN cur_sum%NOTFOUND n�o � necess�ria neste caso, pois estamos buscando um �nico valor agregado. O cursor � aberto, a soma � recuperada, e o cursor � fechado.
DECLARE
  CURSOR cur_sum IS
    SELECT COUNT(*) AS Total_Sistemas FROM t_sistema;
  v_total_sistemas NUMBER;
BEGIN
  OPEN cur_sum;
  FETCH cur_sum INTO v_total_sistemas;
  CLOSE cur_sum;
  DBMS_OUTPUT.PUT_LINE('Total de Sistemas: ' || v_total_sistemas);
END;
/


-- Bloco An�nimo 3: Sumariza��o de Dados Agrupados da Tabela t_autoridade_ambiental
-- Cursor Expl�cito: O cursor cur_grouped_sum � declarado e utilizado explicitamente.
-- Tomada de Decis�o: A instru��o EXIT WHEN cur_grouped_sum%NOTFOUND � utilizada para sair do loop quando n�o houver mais registros.
DECLARE
  CURSOR cur_grouped_sum IS
    SELECT ID_AUTORIDADE_AMBIENTAL, COUNT(*) AS Sub_Total
    FROM t_autoridade_ambiental
    GROUP BY ID_AUTORIDADE_AMBIENTAL;
  v_id_autoridade_ambiental t_autoridade_ambiental.ID_AUTORIDADE_AMBIENTAL%TYPE;
  v_sub_total NUMBER;
BEGIN
  OPEN cur_grouped_sum;
  LOOP
    FETCH cur_grouped_sum INTO v_id_autoridade_ambiental, v_sub_total;
    EXIT WHEN cur_grouped_sum%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID_AUTORIDADE_AMBIENTAL: ' || v_id_autoridade_ambiental || ' Sub-Total: ' || v_sub_total);
  END LOOP;
  CLOSE cur_grouped_sum;
END;
/


-- Bloco An�nimo 4: Relat�rio Completo da Tabela t_usuario
-- Cursor Expl�cito: Os cursores cur_all_data e cur_grouped_sum s�o declarados e utilizados explicitamente.
-- Tomada de Decis�o: As instru��es EXIT WHEN cur_all_data%NOTFOUND e EXIT WHEN cur_grouped_sum%NOTFOUND s�o utilizadas para sair dos loops quando n�o houver mais registros.
DECLARE
  CURSOR cur_all_data IS
    SELECT ID_USUARIO, DS_USUARIO, NM_USUARIO
    FROM T_USUARIO
    ORDER BY ID_USUARIO;
  CURSOR cur_grouped_sum IS
    SELECT ID_USUARIO, COUNT(*) AS Sub_Total
    FROM T_USUARIO
    GROUP BY ID_USUARIO;
  v_id_usuario T_USUARIO.ID_USUARIO%TYPE;
  v_ds_usuario T_USUARIO.DS_USUARIO%TYPE;
  v_nm_usuario T_USUARIO.NM_USUARIO%TYPE;
  v_sub_total NUMBER;
  v_total_geral NUMBER := 0;
BEGIN
  OPEN cur_all_data;
  LOOP
    FETCH cur_all_data INTO v_id_usuario, v_ds_usuario, v_nm_usuario;
    EXIT WHEN cur_all_data%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_id_usuario || ' ' || v_ds_usuario || ' ' || v_nm_usuario);
    v_total_geral := v_total_geral + 1; -- Contagem simples de registros
  END LOOP;
  CLOSE cur_all_data;

  DBMS_OUTPUT.PUT_LINE('--- Sub-Totais por ID_USUARIO ---');

  OPEN cur_grouped_sum;
  LOOP
    FETCH cur_grouped_sum INTO v_id_usuario, v_sub_total;
    EXIT WHEN cur_grouped_sum%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID_USUARIO: ' || v_id_usuario || ' Sub-Total: ' || v_sub_total);
  END LOOP;
  CLOSE cur_grouped_sum;

  DBMS_OUTPUT.PUT_LINE('Total Geral: ' || v_total_geral);
END;
/


