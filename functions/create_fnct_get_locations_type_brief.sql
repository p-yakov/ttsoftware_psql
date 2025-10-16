create or replace function fnct_get_locations_type_brief (v_id smallint)
returns varchar(82)
language plpgsql
as $$
/**********************************************************************
Функция для возврата сокращенного наименование типа локации из таблицы locations_type

Входные параметры:
 v_id - идентификатор типа локации (locations_type.id)
**********************************************************************/
begin
  return coalesce((select brief
                     from locations_type
                    where id = coalesce(v_id, 0)), '');
end
$$;

grant execute on function fnct_get_locations_type_brief (smallint) to role_user
                                                                     ,role_org
                                                                     ,role_admin;