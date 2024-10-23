set serveroutput on
set verify off


BEGIN
  DBMS_OUTPUT.PUT_LINE('Teste de saída DBMS_OUTPUT');
END;
/

-- Bloco Anônimo 1: Listar Todos os Dados da Tabela t_sistema
-- Cursor Explícito: O cursor cur_all_data é declarado e utilizado explicitamente.
-- Tomada de Decisão: A instrução EXIT WHEN cur_all_data%NOTFOUND é utilizada para sair do loop quando não houver mais registros.
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


-- Bloco Anônimo 2: Mostrar Dados Numéricos Sumarizados da Tabela t_sistema
-- Cursor Explícito: O cursor cur_sum é declarado e utilizado explicitamente.
-- Tomada de Decisão: A instrução EXIT WHEN cur_sum%NOTFOUND não é necessária neste caso, pois estamos buscando um único valor agregado. O cursor é aberto, a soma é recuperada, e o cursor é fechado.
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


-- Bloco Anônimo 3: Sumarização de Dados Agrupados da Tabela t_autoridade_ambiental
-- Cursor Explícito: O cursor cur_grouped_sum é declarado e utilizado explicitamente.
-- Tomada de Decisão: A instrução EXIT WHEN cur_grouped_sum%NOTFOUND é utilizada para sair do loop quando não houver mais registros.
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


-- Bloco Anônimo 4: Relatório Completo da Tabela t_usuario
-- Cursor Explícito: Os cursores cur_all_data e cur_grouped_sum são declarados e utilizados explicitamente.
-- Tomada de Decisão: As instruções EXIT WHEN cur_all_data%NOTFOUND e EXIT WHEN cur_grouped_sum%NOTFOUND são utilizadas para sair dos loops quando não houver mais registros.
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


