create or replace procedure proc_insert_roles (v_name varchar(16))
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу roles

Входные параметры:
 v_name - наименование
**********************************************************************/
begin
  v_name := coalesce(trim(v_name), '');

  if v_name = '' then
    raise exception 'Наименование роли не задано';
  end if;

  if exists (select 1 
               from roles 
              where name = v_name) then
    raise exception 'Роль с наименованием "%" уже существует', v_name;
  end if;

  insert into roles (name)
  values (v_name);
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу roles: %', sqlerrm;
end
$$;