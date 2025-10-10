create or replace procedure proc_mass_update_countries()
language plpgsql
as $$
/**********************************************************************
Процедура для массового обновления записей (стран, субъектов, городов и т.д.) в таблице countries

Входная таблица temp_countries (id                int  not null  --уникальный идентификатор таблицы countries
                               ,name              text not null  --наименование
                               ,parent_id         int  not null  --идентификатор родителя
                               ,countries_type_id int  not null) --идентификатор типа объекта
**********************************************************************/
begin
  if to_regclass('temp_countries') is null then
    raise exception 'Временная таблица temp_countries не существует';
  end if;

  if not exists (select 1 
                   from temp_countries) then
    raise exception 'Временная таблица temp_countries пустая';
  end if;
  
  update countries c
     set name              = t.name
        ,parent_id         = t.parent_id
        ,countries_type_id = t.countries_type_id
    from temp_countries t
   where t.id = c.id
     and (c.name              is distinct from t.name
       or c.parent_id         is distinct from t.parent_id
       or c.countries_type_id is distinct from t.countries_type_id);
exception 
  when others then raise exception 'Ошибка при обновлении записей в таблице countries: %', sqlerrm;
end;
$$;