create or replace procedure proc_update_locations_type (v_id    smallint
                                                       ,v_brief varchar(16)
                                                       ,v_name  varchar(64))
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи (тип субъекта) в таблице locations_type

Входные параметры:
  v_id    - идентификатор записи (locations_type.id)
  v_brief - сокращенное наименование  
  v_name  - полное наименование
**********************************************************************/
begin
  v_id    := coalesce(v_id, 0);
  v_brief := coalesce(trim(v_brief), '');
  v_name  := coalesce(trim(v_name), '');

  if not exists (select 1
                   from locations_type 
                  where id = v_id) then
    raise exception 'Идентификатор типа субъекта "%" не найден', v_id;
  end if;

  if v_brief = '' then
    raise exception 'Не указано сокращенное наименование объекта';
  end if;  

  if v_name = '' then
    raise exception 'Не указано наименование объекта';
  end if;

  if exists (select 1 
               from locations_type 
              where brief = v_brief
                and name  = v_name) then
    raise exception 'В таблице locations_type "%s" уже существует', v_name;
  end if;
  
  update locations_type
     set brief = v_brief
        ,name  = v_name
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице locations_type: %', sqlerrm;
end
$$;