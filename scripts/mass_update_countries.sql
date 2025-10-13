drop table if exists temp_countries;
create temp table temp_countries (id                int  not null  --уникальный идентификатор таблицы countries
                                 ,name              text not null  --наименование
                                 ,parent_id         int  not null  --идентификатор родителя
                                 ,countries_type_id int  not null); --идентификатор типа объекта
                            
do $$
declare v_countries_type_id int := fnct_get_countries_type_id('Страна');
begin
  insert into temp_countries (id
                             ,name
                             ,parent_id
                             ,countries_type_id)
  select id
        ,name
        ,parent_id
        ,v_countries_type_id
    from countries
   where countries_type_id is null
     and parent_id = 0;

  call proc_mass_update_countries();
end
$$;