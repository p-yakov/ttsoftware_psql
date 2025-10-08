create or replace function fnct_get_errors_message (v_code int)
returns text
language plpgsql
/**********************************************************************
Функция для возврата текста ошибки

Возвращает: текст ошибки
**********************************************************************/
as $$
begin
  return coalesce((select message
                     from errors 
                    where code = v_code)
                 ,'');
end
$$;

grant execute on function fnct_get_errors_message (int) to role_guest
                                                          ,role_user
                                                          ,role_org
                                                          ,role_admin;