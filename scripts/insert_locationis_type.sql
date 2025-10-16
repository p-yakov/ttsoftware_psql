drop table if exists temp_locations_type;

create temp table temp_locations_type (brief varchar(16) not null
                                      ,name  varchar(64) not null);

do $$
  declare elem json;
          list json;
          rec  record;
begin
  --страны
  insert into temp_locations_type (brief, name)
  values ('стр-на', 'Страна');

  --субъекты
  list := '[
    { "brief": "респ", "name": "Республика" },
    { "brief": "край", "name": "Край" },
    { "brief": "обл", "name": "Область" },
    { "brief": "г", "name": "Город федерального значения" },
    { "brief": "авт обл", "name": "Автономная область" },
    { "brief": "авт округ", "name": "Автономный округ" }
  ]';
  for elem in select json_array_elements(list) loop
    insert into temp_locations_type (brief, name)
    values (elem ->> 'brief', elem ->> 'name');
  end loop;

  --населенные пункты
  list := '[
    { "brief": "г", "name": "Город" },
    { "brief": "пгт", "name": "Посёлок городского типа" },
    { "brief": "рп", "name": "Рабочий посёлок" },
    { "brief": "кп", "name": "Курортный посёлок" },
    { "brief": "дп", "name": "Дачный посёлок" },
    { "brief": "с", "name": "Село" },
    { "brief": "д", "name": "Деревня" },
    { "brief": "х", "name": "Хутор" },
    { "brief": "ст", "name": "Станица" },
    { "brief": "аул", "name": "Аул" },
    { "brief": "пос", "name": "Посёлок" },
    { "brief": "сл", "name": "Слобода" },
    { "brief": "мест", "name": "Местечко" },
    { "brief": "высел", "name": "Выселки" },
    { "brief": "п/ст", "name": "Железнодорожная платформа/разъезд" },
    { "brief": "ж/д_будка", "name": "Железнодорожная будка" },
    { "brief": "ж/д_казарм", "name": "Железнодорожная казарма" },
    { "brief": "зим", "name": "Зимовье" }
  ]';
  for elem in select json_array_elements(list) loop
    insert into temp_locations_type (brief, name)
    values (elem ->> 'brief', elem ->> 'name');
  end loop;

  --добавления данных
  for rec in select brief
                   ,name
               from temp_locations_type loop
    begin
      call proc_insert_locations_type (rec.brief, rec.name);
      exception 
        when others then raise warning 'Ошибка по записи brief = %; name = %: %', rec.brief, rec.name, sqlerrm;
    end;
  end loop;
end $$;

--select * from temp_locations_type;
select * from locations_type;
