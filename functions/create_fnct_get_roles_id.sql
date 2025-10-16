create or replace function fnct_get_roles_id (v_name varchar(16))
returns smallint
language plpgsql
as $$
/**********************************************************************
Функция для возврата идентификатора роли из таблицы roles

Входные параметры:
 v_name - наименование роли
**********************************************************************/
begin
  return coalesce((select id 
                     from roles
                    where name = coalesce(v_name, '')), 0);
end
$$;

grant execute on function fnct_get_roles_id (varchar) to role_user
                                                        ,role_org
                                                        ,role_admin;