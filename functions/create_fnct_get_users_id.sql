create or replace function fnct_get_users_id (v_login varchar(32))
returns smallint
language plpgsql
as $$
/**********************************************************************
Функция для возврата идентификатора пользователя из таблицы users

Входные параметры:
 v_login - логин
**********************************************************************/
begin
  return coalesce((select id 
                     from users
                    where login = coalesce(v_login, '')), 0);
end
$$;

grant execute on function fnct_get_users_id (varchar) to role_user
                                                        ,role_org
                                                        ,role_admin;