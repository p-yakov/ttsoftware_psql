create or replace procedure proc_update_locations (v_id                int
                                                  ,v_name              varchar(128)
                                                  ,v_parent_id         int
                                                  ,v_locations_type_id smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице locations

Входные параметры:
  v_id                - идентификатор
  v_name              - наименование
  v_parent_id         - идентификатор родителя
  v_locations_type_id - идентификатор типа
**********************************************************************/
  declare v_locations_type_brief varchar(16);
begin
  v_id                := coalesce(v_id, 0);
  v_name              := coalesce(trim(v_name), '');
  v_parent_id         := coalesce(v_parent_id, -1);
  v_locations_type_id := coalesce(v_locations_type_id, 0);
  
  if not exists (select 1
                   from locations
                  where id = v_id) then
    raise exception 'Идентификатор в таблице locations "%" не найден', v_id;
  end if;

  if v_name = '' then
    raise exception 'Не указано наименование';
  end if;
  
  if v_locations_type_id = 0 then
    raise exception 'Не указан идентификатор типа';
  end if;
  
  v_locations_type_brief := fnct_get_locations_type_brief(v_locations_type_id);
  
  if v_parent_id = 0 and v_locations_type_brief != 'стр-на' then
    raise exception 'Не указан родитель';
  end if;  
  
  if v_parent_id != 0 and not exists (select 1 
                                        from locations 
                                       where id = v_parent_id) then
    raise exception 'Идентификатор родителя "%" не найден', v_parent_id;
  end if;

  if exists (select 1 
               from locations 
              where name              = v_name
                and parent_id         = v_parent_id
                and locations_type_id = v_locations_type_id) then
    raise exception 'В таблице locations существует запись: %', v_name;
  end if;
  
  update locations 
     set name              = v_name
        ,parent_id         = v_parent_id
        ,locations_type_id = v_locations_type_id
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу locations: %', sqlerrm;
end
$$;