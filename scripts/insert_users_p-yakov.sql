do
$$
declare error_code    int;
        error_message text;
begin
  call proc_insert_users('p-yakov', crypt('123', gen_salt('bf')), error_code);

  error_message := fnct_get_errors_message(error_code);
  
  raise notice 'Code = %; Message = %', error_code, error_message;
end
$$;