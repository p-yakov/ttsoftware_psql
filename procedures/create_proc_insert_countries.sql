create or replace procedure proc_insert_countries (v_name      text
                                                  ,v_parent_id int)
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи (стран, субъектов, городов и т.д.) в таблицу countries

Входные параметры:
  v_name      - наименование
  v_parent_id - идентификатор родителя
**********************************************************************/
declare v_parent_name text;

begin
  if coalesce(v_name, '') = '' then
    raise exception 'Не указано наименование объекта';
  end if;

  if not exists (select 1
                   from countries 
                  where id = coalesce(v_parent_id, -1)) then
    raise exception 'Не найден родитель';
  end if;

  select p.name
    into v_parent_name
    from countries o
    join countries p
      on o.id = v_parent_id
   where o.id        = v_id
     and o.parent_id = v_parent_id;

  if v_parent_name is not null then
    raise exception 'В таблице countries существует запись: % - %', v_parent_name, v_name;
  end if;
  
  insert into countries (name
                        ,parent_id)
  values (v_name
         ,v_parent_id);
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу countries: %', sqlerrm;
end
$$;

grant execute on procedure proc_insert_countries (text, int) to role_admin;