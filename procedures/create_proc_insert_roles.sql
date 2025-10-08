create or replace procedure proc_insert_roles (v_name     text
                                              ,out v_code int)
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу roles

Входные параметры:
 v_name - наименование

Возвращает:
 v_code - номер ошибки или 0
**********************************************************************/
begin
  if coalesce(v_name, '') = '' then
    v_code = 6;
    return;
  end if;

  insert into roles (name)
  values (v_name);
  
  v_code := 0;
end
$$;