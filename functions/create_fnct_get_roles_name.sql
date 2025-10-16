create or replace function fnct_get_roles_name (v_id smallint)
returns varchar(16)
language plpgsql
as $$
/**********************************************************************
Функция для возврата наименование роли из таблицы roles

Входные параметры:
 v_id - идентификатор записи
**********************************************************************/
begin
  return coalesce((select name 
                     from roles
                    where id = coalesce(v_id, 0)), '');
end
$$;

grant execute on function fnct_get_roles_name (smallint) to role_user
                                                           ,role_org
                                                           ,role_admin;