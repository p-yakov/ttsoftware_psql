create or replace function fnct_get_errors_message (v_id int)
returns text
language plpgsql
as $$
begin
  return coalesce((select message
                    from errors 
                   where id = v_id)
                 ,0);
end
$$;