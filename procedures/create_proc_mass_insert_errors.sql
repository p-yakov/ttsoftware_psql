create or replace procedure proc_mass_insert_errors(out v_message text)
language plpgsql
as $$
/**********************************************************************
Процедура для массовой вставки ошибок процессов

Входная таблица temp_errors (message       text          not null  --сообщения об ошибки
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
     set message_error = 'Запись существует в основной таблице errors'
    from errors e
   where e.message = t.message;
  
  update temp_errors
     set message_error = 'В таблице temp_errors поле message пустое'
   where message = '';

  update temp_errors
     set message_error = 'В таблице temp_errors поле process_name пустое'
   where process_name = '{}'::varchar[];
  
  insert into errors (message
                     ,process_name)
  select message
        ,process_name
    from temp_errors
   where message_error is null;

  v_message := '';
end
$$;