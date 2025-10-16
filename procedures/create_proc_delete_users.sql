create or replace procedure proc_delete_users (v_id int)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи в таблице users

Входные параметры:
 v_id - идентификатор в таблице
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);

  if not exists (select 1 
                   from users 
                  where id = v_id) then
    raise exception 'Пользователь с идентификатором "%" не найден', v_id;
  end if;

  if exists (select 1
               from users_roles 
              where users_id = v_id) then
    raise exception 'Найдена связь идентификатора "%" с таблицей users_roles', v_id;
  end if;

  delete 
    from users
   where id = v_id;
exception
  when others then raise exception 'Ошибка при удалении записи в таблице users: %', sqlerrm;
end
$$;