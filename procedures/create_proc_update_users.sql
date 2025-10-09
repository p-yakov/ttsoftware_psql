create or replace procedure proc_update_users (v_id       int
                                              ,v_password varchar(64))
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице users

Входные параметры:
 v_id       - идентификатор пользователя
 v_password - пароль
**********************************************************************/
begin
  if not exists (select 1 
                   from users 
                  where id = v_id) then
    raise exception 'Логин не найден';
  end if;
  
  if coalesce(v_password, '') = '' then
    raise exception 'Пароль не задан';
  end if;

  if length(v_password) > 64 then
    raise exception 'Длина пароля состовляет более 64 симовлов';
  end if;

  update users
     set password = v_password
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице users: %', sqlerrm;
end
$$;

grant execute on procedure proc_update_users (int, varchar) to role_user
                                                              ,role_org
                                                              ,role_admin;