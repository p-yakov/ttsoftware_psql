create or replace procedure proc_insert_users (v_login    varchar(64)
                                              ,v_password varchar(64))
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу users

Входные параметры:
 v_login    - логин
 v_password - пароль
**********************************************************************/
begin
  if coalesce(v_login, '') = '' then
    raise exception 'Логин не задан';
  end if;

  if coalesce(v_password, '') = '' then
    raise exception 'Пароль не задан';
  end if;

  if exists (select 1 
               from users
              where login = v_login) then
    raise exception 'Логин "%" уже существует', v_login;
  end if;

  if length(v_login) > 64 then
    raise exception 'Длина логина состовляет более 64 симовлов';
  end if;

  if length(v_password) > 64 then
    raise exception 'Длина пароля состовляет более 64 симовлов';
  end if;

  insert into users (login
                    ,password)
  values (v_login
         ,v_password);
exception 
  when others then raise exception 'Ошибка при добавлении записей в таблицу users: %', sqlerrm;
end
$$;

grant execute on procedure proc_insert_users (varchar, varchar) to role_guest;