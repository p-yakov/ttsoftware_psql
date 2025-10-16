create or replace procedure proc_delete_locations (v_id int)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи с таблицы locations

Входные параметры:
  v_id - идентификатор
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);
  
  if not exists (select 1
                   from locations
                  where id = v_id) then
    raise exception 'Идентификатор в таблице locations "%" не найден', v_id;
  end if;

  if exists (select 1 
               from locations 
              where parent_id = v_id) then
    raise exception 'Найдена связь идентификатора "%" с таблицей locations', v_id;
  end if;
  
  delete 
    from locations
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при удалении записи с таблицы locations: %', sqlerrm;
end
$$;