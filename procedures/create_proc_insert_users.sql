create or replace procedure proc_insert_users (v_login    varchar(64)
                                              ,v_password varchar(64)
                                              ,out v_code int)
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу users

Входные параметры:
 v_login    - логин
 v_password - пароль
 
Возвращает:
 v_code - номер ошибки или 0
**********************************************************************/
begin
  if coalesce(v_login, '') = '' then
    v_code = 1;
    return;
  end if;

  if coalesce(v_password, '') = '' then
    v_code = 2;
    return;
  end if;

  if exists (select 1 
               from users
              where login = v_login) then
    v_code = 3;
    return;
  end if;

  if length(v_login) > 64 then
    v_code = 4;
    return;
  end if;

  if length(v_password) > 64 then
    v_code = 5;
    return;
  end if;

  insert into users (login, password)
  values (v_login, v_password);

  v_code := 0;
end
$$;

grant execute on procedure proc_insert_users (varchar, varchar, int) to role_guest;