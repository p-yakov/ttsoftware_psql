create or replace procedure proc_insert_players (v_family       varchar(64)
                                                ,v_name         varchar(64)
                                                ,v_sur_name     varchar(64)
                                                ,v_date_birth   date
                                                ,v_locations_id int
                                                ,v_genders_id   smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для добавления записи (игроков) в таблицу players

Входные параметры:
  v_family       - фамилия
  v_name         - имя
  v_sur_name     - отчество
  v_date_birth   - дата рождения
  v_locations_id - идентификатор локации (locations.id)
  v_genders_id   - идентификатор пола (genders.id)
**********************************************************************/
begin
  v_family       := coalesce(trim(v_family), '');
  v_name         := coalesce(trim(v_name), '');
  v_sur_name     := coalesce(trim(v_sur_name), '');
  v_locations_id := coalesce(v_locations_id, 0);
  v_genders_id   := coalesce(v_genders_id, 0);

  if v_family = '' then
    raise exception 'Не указана фамилия';
  end if;

  if v_name = '' then
    raise exception 'Не указано имя';
  end if;

  if v_sur_name = '' then
    raise exception 'Не указано отчество';
  end if;

  if v_date_birth is null then
    raise exception 'Не указана дата рождения';
  end if;

  if v_locations_id = 0 then
    raise exception 'Не указан населенный пункт';
  end if;

  if v_genders_id = 0 then
    raise exception 'Не указан пол';
  end if;

  if not exists (select 1 
                   from locations 
                  where id = v_locations_id) then
    raise exception 'Идентификатор в таблице locations "%" не найден', v_locations_id;
  end if;

  if not exists (select 1 
                   from genders 
                  where id = v_genders_id) then
    raise exception 'Идентификатор в таблице genders "%" не найден', v_genders_id;
  end if;

  insert into players (family
                      ,name
                      ,sur_name
                      ,date_birth
                      ,locations_id
                      ,genders_id
                      ,users_id)
  values (v_family
         ,v_name
         ,v_sur_name
         ,v_date_birth
         ,v_locations_id
         ,v_genders_id
         ,fnct_get_users_id(current_setting('ttsoftware.user_login', true)));
exception
  when others then raise exception 'Ошибка при добавлении записи в таблицу players: %', sqlerrm;
end $$;

grant execute on procedure proc_insert_players (varchar, varchar, varchar, date, int, smallint) to role_user
                                                                                                  ,role_org
                                                                                                  ,role_admin;