do $$
  declare array_process_name varchar(64)[];
          v_code             int;
          v_message          text;
begin  
  drop table if exists temp_errors;
  
  create temp table temp_errors (code         int           not null   --код ошибки
                                ,message      text          not null   --сообщения об ошибки
                                ,process_name varchar(64)[] not null); --процесс где возникает ошибка
  
  array_process_name := array['proc_insert_users'];
  
  insert into temp_errors (code, message, process_name)
  values (1, 'Логин не может быть пустым', array_process_name)
        ,(2, 'Пароль не может быть пустым', array_process_name)
        ,(3, 'Логин уже существует', array_process_name);
  
  call proc_mass_update_errors (v_code, v_message);

  raise notice 'Code = %; Message = %', v_code, v_message;
end
$$;