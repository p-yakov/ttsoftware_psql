drop table if exists temp_errors;
  
create temp table temp_errors (code          int           not null   --код ошибки
                              ,message       text          not null   --сообщения об ошибки
                              ,process_name  varchar(64)[] not null   --процесс где возникает ошибка
                              ,message_error text              null); --сообщение об ошибке
do $$
declare array_process_name varchar(64)[];
        v_message          text;
begin  
  --начало: ошибки для процесса по таблице users
  array_process_name := array['proc_insert_users'];
  
  insert into temp_errors (code, message, process_name)
  select code
        ,replace(message, '128', '64')
        ,process_name
    from errors
   where message = 'Логин не может содержать более 128 символов';  
  --конец: ошибки для процесса по таблице users
  
  call proc_mass_update_errors (v_message);

  raise notice 'Message = %', v_message;
end
$$;

select * from temp_errors;