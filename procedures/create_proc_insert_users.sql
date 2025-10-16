create or replace procedure proc_insert_users (v_login    varchar(32)
                                              ,v_password char(60))
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу users

Входные параметры:
 v_login    - логин
 v_password - пароль
**********************************************************************/
begin
  v_login    := coalesce(trim(v_login), '');
  v_password := coalesce(trim(v_password), '');

  if v_login = '' then
    raise exception 'Логин не задан';
  end if;

  if v_password = '' then
    raise exception 'Пароль не задан';
  end if;

  if exists (select 1 
               from users
              where login = v_login) then
    raise exception 'Логин "%" уже существует', v_login;
  end if;

  insert into users (login
                    ,password)
  values (v_login
         ,v_password);
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу users: %', sqlerrm;
end
$$;

grant execute on procedure proc_insert_users (varchar, char) to role_guest
                                                               ,role_admin;