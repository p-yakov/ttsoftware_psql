create or replace procedure proc_delete_roles (v_id smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи в таблице roles

Входные параметры:
 v_id - идентификатор в таблице
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);

  if not exists (select 1 
                   from roles 
                  where id = v_id) then
    raise exception 'Роль с идентификатором "%" не найдена', v_id;
  end if;

  if exists (select 1 
               from users_roles 
              where roles_id = v_id) then
    raise exception 'Найдена связь идентификатора "%" с таблицей users_roles', v_id;
  end if;

  delete 
    from roles
   where id = v_id;
exception
  when others then raise exception 'Ошибка при удалении записи в таблице roles: %', sqlerrm;
end
$$;