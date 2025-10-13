drop table if exists temp_countries_type;
create temp table temp_countries_type (name varchar(64) not null); --наименование

do $$
declare elem json;
        list json := '{
  "date": "2025-10",
  "типы_субъектов_рф": [
    {
      "тип": "республика",
      "полное_наименование": "Республика"
    },
    {
      "тип": "край",
      "полное_наименование": "Край"
    },
    {
      "тип": "область",
      "полное_наименование": "Область"
    },
    {
      "тип": "город_федерального_значения",
      "полное_наименование": "Город федерального значения"
    },
    {
      "тип": "автономная_область",
      "полное_наименование": "Автономная область"
    },
    {
      "тип": "автономный_округ",
      "полное_наименование": "Автономный округ"
    }
  ]
}';
begin
  insert into temp_countries_type (name)
  values ('Страна');  

  for elem in select json_array_elements(list -> 'типы_субъектов_рф')
  loop
    insert into temp_countries_type (name)
    values (elem ->> 'полное_наименование');
  end loop;

  call proc_mass_insert_countries_type();
end
$$;