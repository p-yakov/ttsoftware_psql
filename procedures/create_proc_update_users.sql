create or replace procedure proc_update_users (v_id       int
                                              ,v_password varchar(64)
                                              ,out v_code int)
language plpgsql
as $$
/**********************************************************************
Процедура для обновлении записи в таблице users

Входные параметры:
 v_id       - идентификатор пользователя
 v_password - пароль
 
Возвращает:
 v_code - номер ошибки или 0
**********************************************************************/
begin
  if not exists (select 1 
                   from users 
                  where id = v_id) then
    v_code = 6;
    return;
  end if;
  
  if coalesce(v_password, '') = '' then
    v_code = 2;
    return;
  end if;

  if length(v_password) > 64 then
    v_code = 5;
    return;
  end if;

  update users
     set password = v_password
   where id = v_id;
  
  v_code := 0;
end
$$;

grant execute on procedure proc_update_users (int, varchar, int) to role_user
                                                                   ,role_org
                                                                   ,role_admin;