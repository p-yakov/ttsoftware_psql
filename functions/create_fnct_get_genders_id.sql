create or replace function fnct_get_genders_id (v_brief char(1))
returns smallint
language plpgsql
as $$
/**********************************************************************
Функция для возврата идентификатора пола из таблицы genders

Входные параметры:
 v_brief - сокращенное наименование пола
**********************************************************************/
begin
  return coalesce((select id 
                     from genders
                    where brief = coalesce(v_brief, '')), 0);
end
$$;

grant execute on function fnct_get_genders_id (char) to role_user
                                                       ,role_org
                                                       ,role_admin;