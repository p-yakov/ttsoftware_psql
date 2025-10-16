create or replace function fnct_get_locations_type_id (v_name varchar(64))
returns smallint
language plpgsql
as $$
/**********************************************************************
Функция для возврата идентификатора типа локации из таблицы locations_type

Входные параметры:
 v_name - наименование типа локации
**********************************************************************/
begin
  return coalesce((select id 
                     from locations_type
                    where name = coalesce(v_name, '')), 0);
end
$$;

grant execute on function fnct_get_locations_type_id (varchar) to role_user
                                                                 ,role_org
                                                                 ,role_admin;