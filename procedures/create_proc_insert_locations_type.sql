create or replace procedure proc_insert_locations_type (v_brief varchar(16)
                                                       ,v_name  varchar(64))
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи (тип субъекта) в таблицу locations_type

Входные параметры:
  v_brief - сокрашенное наименование  
  v_name  - полное наименование
**********************************************************************/
begin
  v_brief := coalesce(trim(v_brief), '');
  v_name  := coalesce(trim(v_name), '');

  if v_brief = '' then
    raise exception 'Не указано сокращенное наименование';
  end if;

  if v_name = '' then
    raise exception 'Не указано наименование';
  end if;

  if exists (select 1 
               from locations_type 
              where brief = v_brief
                and name  = v_name) then
    raise exception 'В таблице locations_type существует запись: % - %', v_brief, v_name;
  end if;
  
  insert into locations_type (brief
                             ,name)
  values (v_brief
         ,v_name);
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу locations_type: %', sqlerrm;
end
$$;