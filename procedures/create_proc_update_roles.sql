create or replace procedure proc_update_roles (v_id int
                                              ,v_name text)
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице roles

Входные параметры:
 v_id   - идентификатор роли
 v_name - наименование
**********************************************************************/
begin
  if coalesce(v_name, '') = '' then
    raise exception 'Наименование роли не задано';
  end if;

  if not exists (select 1 
                  from roles 
                 where id = v_id) then
    raise exception 'Роль не найдена';
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