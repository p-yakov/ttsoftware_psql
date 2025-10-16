create or replace procedure proc_update_genders (v_id    smallint
                                                ,v_brief char(1)
                                                ,v_name  varchar(8))
language plpgsql
as $$
/**********************************************************************
Процедура для изменения записи в таблице genders

Входные параметры:
  v_id    - идентификатор записи (genders.id)
  v_brief - сокращенное наименование
  v_name  - полное наименование
**********************************************************************/
begin
  v_id    := coalesce(v_id, 0);
  v_brief := coalesce(trim(v_brief), '');
  v_name  := coalesce(trim(v_name), '');

  if not exists (select 1 
                   from genders
                  where id = v_id) then
    raise exception 'Идентификатор пола "%" не найден', v_id;
  end if;  

  if v_brief = '' then
    raise exception 'Не указано сокращенное наименование';
  end if;

  if v_name = '' then
    raise exception 'Не указано полное наименование';
  end if;

  if exists (select 1
               from genders
              where brief = v_brief 
                and name  = v_name) then
    raise exception 'В таблице genders существует запись: % - %', v_brief, v_name;
  end if;
    
  update genders
     set brief = v_brief
        ,name  = v_name
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице genders: %', sqlerrm;
end
$$;