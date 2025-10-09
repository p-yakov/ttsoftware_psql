create or replace procedure proc_mass_insert_countries()
language plpgsql
as $$
/**********************************************************************
Процедура для массовой вставки записей (стран, субъектов, городов и т.д.) в таблицу countries

Входная таблица temp_countries (name      text not null  --наименование
                               ,parent_id int  not null) --идентификатор родителя
**********************************************************************/
declare v_duplicate text;

begin
  if to_regclass('temp_countries') is null then
    raise exception 'Временная таблица temp_countries не существует';
  end if;

  if not exists (select 1 
                   from temp_countries) then
    raise exception 'Временная таблица temp_countries пустая';
  end if;

  select string_agg(distinct format('%s - %s', c.name, p.name), ', ')
    into v_duplicate
    from temp_countries t
    join countries c
      on c.name      = t.name
     and c.parent_id = t.parent_id
    join countries p
      on p.id = t.parent_id;
        
  if v_duplicate is not null then
    raise exception 'В таблице countries существует запись: %', v_duplicate;
  end if;
  
	insert into countries(name
                       ,parent_id)
	select name
        ,parent_id
	  from temp_countries;
exception 
  when others then raise exception 'Ошибка при добавлении записей в таблицу countries: %', sqlerrm;
end;
$$;