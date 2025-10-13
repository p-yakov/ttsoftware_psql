create or replace function fnct_get_countries_id (v_name text)
returns int
language plpgsql
as $$
begin
  return coalesce((select id 
                     from countries
                    where name = v_name), 0);
end
$$;