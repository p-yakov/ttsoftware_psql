create or replace function fnct_get_countries_type_id (v_name varchar(64))
returns int
language plpgsql
as $$
begin
  return coalesce((select id 
                     from countries_type 
                    where name = v_name), 0);
end
$$;