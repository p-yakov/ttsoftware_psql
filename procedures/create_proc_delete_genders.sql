create or replace procedure proc_delete_genders (v_id smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи в таблице genders

Входные параметры:
  v_id - идентификатор записи (genders.id)
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);

  if not exists (select 1 
                   from genders
                  where id = v_id) then
    raise exception 'Идентификатор пола "%" не найден', v_id;
  end if;

  if exists (select 1 
               from players 
              where genders_id = v_id) then
    raise exception 'Найдена связь идентификатора "%" с таблицей players', v_id;
  end if;
    
  delete 
    from genders
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице genders: %', sqlerrm;
end
$$;