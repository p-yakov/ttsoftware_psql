create or replace function fnct_get_locations_id (v_name varchar(128))
returns int
language plpgsql
as $$
begin
  return coalesce((select id 
                     from locations
                    where name = v_name), 0);
end
$$;