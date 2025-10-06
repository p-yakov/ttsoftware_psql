create or replace procedure proc_mass_update_errors (out v_message text)
language plpgsql
as $$
/**********************************************************************
Процедура для массового обновления ошибок процессов

Входная таблица temp_errors (code          int           not null  --код ошибки
                            ,message       text          not null  --сообщения об ошибки
                            ,process_name  varchar(64)[] not null  --процесс где возникает ошибка
                            ,message_error text              null) --сообщение об ошибке

Возвращает:
 v_message - сообщение об ошибке
**********************************************************************/
begin
  if to_regclass('temp_errors') is null then
    v_message := 'Временная таблица temp_errors не существует';
    return;
  end if;

  if not exists (select 1 
                   from temp_errors) then
    v_message := 'Временная таблица temp_errors не заполнена';
    return;
  end if;

  update temp_errors t
     set message_error = 'Значение отсутствует в таблице errors'
   where not exists (select 1 
                       from errors e 
                      where e.code = t.code);
   
  update temp_errors
     set message_error = concat(case 
                                  when message_error is null 
                                  then message_error 
                                  else concat(message_error, '; ')
                                end
                               ,'В таблице temp_errors поле message пустое')
   where message = '';

  update temp_errors
     set message_error = (case 
                            when message_error is null 
                            then message_error 
                            else concat(message_error, '; ')
                          end
                         ,'В таблице temp_errors поле process_name пустое')
   where process_name = '{}'::varchar[];

  update temp_errors t
     set message_error = 'Не требует обновления'
    from errors e
   where t.message_error is null
     and e.code         = t.code
     and e.message      = t.message
     and e.process_name = t.process_name;
  
  update errors e
     set message      = t.message
        ,process_name = t.process_name
    from temp_errors t
   where t.message_error is null
     and e.code = t.code
     and (e.message      is distinct from t.message
       or e.process_name is distinct from t.process_name);

  v_message := '';
end
$$;