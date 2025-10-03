create or replace procedure proc_mass_update_errors (out v_code    int
                                                    ,out v_message text)
language plpgsql
as $$
/**********************************************************************
Процедура для массового обновления ошибок процессов

Входная таблица temp_errors (code         int           not null  --код ошибки
                            ,message      text          not null  --сообщения об ошибки
                            ,process_name varchar(64)[] not null) --процесс где возникает ошибка
                              
Возвращает:
 v_code: 0 - ок (транзакция фиксируется)
      не 0 - ошибка (транзакция не фиксируется)
 v_message: текст ошибки
**********************************************************************/
begin
  if to_regclass('temp_errors') is null then
    v_code := 1;
    v_message := 'Временная таблица temp_errors не существует';
    return;
  end if;

  if not exists (select 1 
                   from temp_errors t 
                   join errors e
                     on e.code = t.code) then
    v_code := 2;
    v_message := 'В таблице errors не существуют данных которые хранятся во временной таблице temp_errors';
    return;
  end if;

  if exists (select 1 
               from temp_errors 
              where message      = '' 
                 or process_name = '{}'::varchar[]) then
    v_code := 3;
    v_message := 'В таблице temp_errors существуют пустые значениям в столбце message или process_name';
    return;
  end if;
  
  update errors e
     set message      = t.message
        ,process_name = t.process_name
    from temp_errors t
    where e.code = t.code
      and (e.message      is distinct from t.message
        or e.process_name is distinct from t.process_name);

  v_code := 0;
  v_message := '';
end
$$;