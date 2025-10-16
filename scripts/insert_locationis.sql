drop table if exists temp_locations;

create temp table temp_locations (name              varchar(128) not null
                                 ,parent_id         int          not null
                                 ,locations_type_id smallint     not null);

create index if not exists idx_temp_locations on temp_locations (parent_id) include (name, locations_type_id);

do $$
  declare v_locations_type_id smallint;
          v_parent_id         int;
          v_elem              json;
          v_list              json;
          v_rec               record;
begin
  --страны
  v_locations_type_id := fnct_get_locations_type_id('Страна');
  v_parent_id := 0;
 
  insert into temp_locations (name
                             ,parent_id
                             ,locations_type_id)
  values ('Российская Федерация'
          ,v_parent_id
          ,v_locations_type_id);

  for v_rec in select name
                     ,parent_id
                     ,locations_type_id
                 from temp_locations 
                where parent_id = v_parent_id loop
    begin
      call proc_insert_locations (v_rec.name, v_rec.parent_id, v_rec.locations_type_id);
      exception 
        when others then raise warning 'Ошибка по записи name = %: %', v_rec.name, sqlerrm;
    end;
  end loop;

  --субъекты
  v_parent_id := fnct_get_locations_id('Российская Федерация');
  v_list := '[
  { "brief": "Республика", "name": "Республика Адыгея" },
  { "brief": "Республика", "name": "Республика Алтай" },
  { "brief": "Республика", "name": "Республика Башкортостан" },
  { "brief": "Республика", "name": "Республика Бурятия" },
  { "brief": "Республика", "name": "Республика Дагестан" },
  { "brief": "Республика", "name": "Донецкая Народная Республика" },
  { "brief": "Республика", "name": "Республика Ингушетия" },
  { "brief": "Республика", "name": "Кабардино-Балкарская Республика" },
  { "brief": "Республика", "name": "Республика Калмыкия" },
  { "brief": "Республика", "name": "Карачаево-Черкесская Республика" },
  { "brief": "Республика", "name": "Республика Карелия" },
  { "brief": "Республика", "name": "Республика Коми" },
  { "brief": "Республика", "name": "Республика Марий Эл" },
  { "brief": "Республика", "name": "Республика Мордовия" },
  { "brief": "Республика", "name": "Республика Саха (Якутия)" },
  { "brief": "Республика", "name": "Республика Северная Осетия — Алания" },
  { "brief": "Республика", "name": "Республика Татарстан" },
  { "brief": "Республика", "name": "Республика Тыва" },
  { "brief": "Республика", "name": "Удмуртская Республика" },
  { "brief": "Республика", "name": "Республика Хакасия" },
  { "brief": "Республика", "name": "Чеченская Республика" },
  { "brief": "Республика", "name": "Чувашская Республика" },
  { "brief": "Край", "name": "Алтайский край" },
  { "brief": "Край", "name": "Забайкальский край" },
  { "brief": "Край", "name": "Камчатский край" },
  { "brief": "Край", "name": "Краснодарский край" },
  { "brief": "Край", "name": "Красноярский край" },
  { "brief": "Край", "name": "Пермский край" },
  { "brief": "Край", "name": "Приморский край" },
  { "brief": "Край", "name": "Ставропольский край" },
  { "brief": "Край", "name": "Хабаровский край" },
  { "brief": "Область", "name": "Амурская область" },
  { "brief": "Область", "name": "Архангельская область" },
  { "brief": "Область", "name": "Астраханская область" },
  { "brief": "Область", "name": "Белгородская область" },
  { "brief": "Область", "name": "Брянская область" },
  { "brief": "Область", "name": "Владимирская область" },
  { "brief": "Область", "name": "Волгоградская область" },
  { "brief": "Область", "name": "Вологодская область" },
  { "brief": "Область", "name": "Воронежская область" },
  { "brief": "Область", "name": "Ивановская область" },
  { "brief": "Область", "name": "Иркутская область" },
  { "brief": "Область", "name": "Калининградская область" },
  { "brief": "Область", "name": "Калужская область" },
  { "brief": "Область", "name": "Кемеровская область" },
  { "brief": "Область", "name": "Кировская область" },
  { "brief": "Область", "name": "Костромская область" },
  { "brief": "Область", "name": "Курганская область" },
  { "brief": "Область", "name": "Курская область" },
  { "brief": "Область", "name": "Ленинградская область" },
  { "brief": "Область", "name": "Липецкая область" },
  { "brief": "Область", "name": "Магаданская область" },
  { "brief": "Область", "name": "Московская область" },
  { "brief": "Область", "name": "Мурманская область" },
  { "brief": "Область", "name": "Нижегородская область" },
  { "brief": "Область", "name": "Новгородская область" },
  { "brief": "Область", "name": "Новосибирская область" },
  { "brief": "Область", "name": "Омская область" },
  { "brief": "Область", "name": "Оренбургская область" },
  { "brief": "Область", "name": "Орловская область" },
  { "brief": "Область", "name": "Пензенская область" },
  { "brief": "Область", "name": "Псковская область" },
  { "brief": "Область", "name": "Ростовская область" },
  { "brief": "Область", "name": "Рязанская область" },
  { "brief": "Область", "name": "Самарская область" },
  { "brief": "Область", "name": "Саратовская область" },
  { "brief": "Область", "name": "Сахалинская область" },
  { "brief": "Область", "name": "Свердловская область" },
  { "brief": "Область", "name": "Смоленская область" },
  { "brief": "Область", "name": "Тамбовская область" },
  { "brief": "Область", "name": "Тверская область" },
  { "brief": "Область", "name": "Томская область" },
  { "brief": "Область", "name": "Тульская область" },
  { "brief": "Область", "name": "Тюменская область" },
  { "brief": "Область", "name": "Ульяновская область" },
  { "brief": "Область", "name": "Челябинская область" },
  { "brief": "Область", "name": "Ярославская область" },
  { "brief": "Область", "name": "Запорожская область" },
  { "brief": "Область", "name": "Херсонская область" },
  { "brief": "Область", "name": "Луганская Народная Республика" },
  { "brief": "Область", "name": "Донецкая Народная Республика" },
  { "brief": "Город федерального значения", "name": "Москва" },
  { "brief": "Город федерального значения", "name": "Санкт-Петербург" },
  { "brief": "Город федерального значения", "name": "Севастополь" },
  { "brief": "Автономная область", "name": "Еврейская автономная область" },
  { "brief": "Автономный округ", "name": "Ненецкий автономный округ" },
  { "brief": "Автономный округ", "name": "Ханты-Мансийский автономный округ — Югра" },
  { "brief": "Автономный округ", "name": "Чукотский автономный округ" },
  { "brief": "Автономный округ", "name": "Ямало-Ненецкий автономный округ" }
]';
  for v_elem in select json_array_elements(v_list) loop
    insert into temp_locations (name
                               ,parent_id
                               ,locations_type_id)
    values (v_elem ->> 'name'
           ,v_parent_id
           ,fnct_get_locations_type_id(v_elem ->> 'brief'));
  end loop;

  for v_rec in select name
                     ,parent_id
                     ,locations_type_id
                 from temp_locations 
                where parent_id = v_parent_id
             order by locations_type_id
                     ,name loop
    begin
      call proc_insert_locations (v_rec.name, v_rec.parent_id, v_rec.locations_type_id);
      exception 
        when others then raise warning 'Ошибка по записи name = %: %', v_rec.name, sqlerrm;
    end;
  end loop;
end $$;