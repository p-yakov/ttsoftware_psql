drop table if exists temp_errors;
  
create temp table temp_errors (message       text          not null   --сообщения об ошибки
                              ,process_name  varchar(64)[] not null   --процесс где возникает ошибка
                              ,message_error text              null); --собщения об ошибки
do $$
declare array_process_name varchar(64)[];
        v_message          text;
begin  
  --начало: ошибки для процесса по таблице users
  array_process_name := array['proc_insert_users', 'proc_update_users'];
  insert into temp_errors ( message, process_name)
  values ('Пароль не может быть пустым', array_process_name)
        ,('Пароль не может содержать более 64 символов', array_process_name);
  
  array_process_name := array_remove(array_process_name, 'proc_update_users');
  insert into temp_errors (message, process_name)
  values ('Логин не может быть пустым', array_process_name)
        ,('Логин уже существует', array_process_name)
        ,('Логин не может содержать более 64 символов', array_process_name);
  
  array_process_name := array['proc_update_users'];
  insert into temp_errors (message, process_name)
  values ('Логин не найден', array_process_name);
  --конец: ошибки для процесса по таблице users
  
  call proc_mass_insert_errors (v_message);  
  raise notice 'Message = %', v_message;
end
$$;

select * from temp_errors;