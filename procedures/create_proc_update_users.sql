create or replace procedure proc_update_users (v_id       int
                                              ,v_password char(60))
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице users

Входные параметры:
 v_id       - идентификатор пользователя
 v_password - пароль
**********************************************************************/
begin
  v_id       := coalesce(v_id, 0);
  v_password := coalesce(trim(v_password), '');

  if not exists (select 1 
                   from users 
                  where id = v_id) then
    raise exception 'Пользователь с идентификатором "%" не найден', v_id;
  end if;
  
  if v_password = '' then
    raise exception 'Пароль не задан';
  end if;

  update users
     set password = v_password
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице users: %', sqlerrm;
end
$$;

grant execute on procedure proc_update_users (int, char) to role_user
                                                           ,role_org
                                                           ,role_admin;