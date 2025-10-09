create or replace procedure proc_insert_roles (v_name text)
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу roles

Входные параметры:
 v_name - наименование
**********************************************************************/
begin
  if coalesce(v_name, '') = '' then
    raise exception 'Наименование роли не задано';
  end if;

  if exists (select 1 from roles where name = v_name) then
    raise exception 'Роль "%" уже существует', v_name;
  end if;

  insert into roles (name)
  values (v_name);
exception 
  when others then raise exception 'Ошибка при добавлении записей в таблицу roles: %', sqlerrm;
end
$$;