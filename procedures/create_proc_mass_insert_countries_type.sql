create or replace procedure proc_mass_insert_countries_type()
language plpgsql
as $$
/**********************************************************************
Процедура для массовой вставки записей (тип объекта) в таблицу countries_type

Входная таблица temp_countries_type (name varchar(64) not null) --наименование                               
**********************************************************************/
declare v_duplicate text;

begin
  if to_regclass('temp_countries_type') is null then
    raise exception 'Временная таблица temp_countries_type не существует';
  end if;

  if not exists (select 1 
                   from temp_countries_type) then
    raise exception 'Временная таблица temp_countries_type пустая';
  end if;

  select string_agg(distinct format('%s', c.name), ', ')
    into v_duplicate
    from temp_countries_type t
    join countries_type c
      on c.name = t.name;

  if v_duplicate is not null then
    raise exception 'В таблице countries_type существует запись: %', v_duplicate;
  end if;
  
  insert into countries_type(name)
  select name
    from temp_countries_type;
exception 
  when others then raise exception 'Ошибка при добавлении записей в таблицу countries_type: %', sqlerrm;
end;
$$;

grant execute on procedure proc_mass_insert_countries_type() to role_admin;