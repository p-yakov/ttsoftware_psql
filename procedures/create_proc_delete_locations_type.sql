create or replace procedure proc_delete_locations_type (v_id smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи в таблице locations_type

Входные параметры:
  v_id - идентификатор записи (locations_type.id)
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);

  if not exists (select 1
                   from locations_type
                  where id = v_id) then
    raise exception 'Идентификатор типа субъекта "%" не найден', v_id;
  end if;  
    
  if exists (select 1 
               from locations 
              where locations_type_id = v_id) then
    raise exception 'Найдена связь идентификатора "%" с таблицей locations', v_id;
  end if;

  delete
    from locations_type
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при удаления записи в таблице locations_type: %', sqlerrm;
end
$$;