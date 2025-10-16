create or replace procedure proc_delete_players (v_id int)
language plpgsql
as $$
/**********************************************************************
Процедура для удаления записи (игрока) в таблицу players

Входные параметры:
  v_id - идентификатор
**********************************************************************/
begin
  v_id := coalesce(v_id, 0);

  if not exists (select 1 
                   from players 
                  where id = v_id) then
    raise exception 'Идентификатор в таблице players "%" не найден', v_id;
  end if;

  delete 
    from players 
   where id = v_id;
exception
  when others then raise exception 'Ошибка при удалении записи из таблицы players: %', sqlerrm;
end $$;

grant execute on procedure proc_delete_players (int) to role_admin;