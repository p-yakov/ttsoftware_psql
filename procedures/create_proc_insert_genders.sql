create or replace procedure proc_insert_genders (v_brief char(1)
                                                ,v_name  varchar(8))
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу genders

Входные параметры:
  v_brief - сокращенное наименование
  v_name  - полное наименование
**********************************************************************/
begin
  v_brief := coalesce(trim(v_brief), '');
  v_name  := coalesce(trim(v_name), '');

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
    
  insert into genders (brief
                      ,name)
  values (v_brief
         ,v_name);
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу genders: %', sqlerrm;
end
$$;