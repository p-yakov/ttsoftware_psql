create or replace procedure proc_update_roles (v_id   smallint
                                              ,v_name varchar(16))
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице roles

Входные параметры:
 v_id   - идентификатор в таблице
 v_name - наименование
**********************************************************************/
begin
  v_id   := coalesce(v_id, 0);
  v_name := coalesce(trim(v_name), '');

  if not exists (select 1 
                  from roles 
                 where id = v_id) then
    raise exception 'Роль с идентификатором "%" не найдена', v_id;
  end if;

  if v_name = '' then
    raise exception 'Наименование роли не задано';
  end if;

  if exists (select 1
               from roles
              where name = v_name) then
    raise exception 'Роль с наименованием "%" уже существует', v_name;
  end if;

  update roles
     set name = v_name
   where id = v_id;
exception
  when others then raise exception 'Ошибка при обновлении записи в таблице roles: %', sqlerrm;
end
$$;