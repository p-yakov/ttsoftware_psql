create or replace function fnct_get_users_login (v_id int)
returns varchar(32)
language plpgsql
as $$
/**********************************************************************
Функция для возврата логина из таблицы users

Входные параметры:
 v_id - идентификатор записи
**********************************************************************/
begin
  return coalesce((select login 
                     from users
                    where id = coalesce(v_id, 0)), '');
end
$$;

grant execute on function fnct_get_users_login (int) to role_user
                                                       ,role_org
                                                       ,role_admin;