create or replace procedure proc_update_players (v_id           int
                                                ,v_family       varchar(64)
                                                ,v_name         varchar(64)
                                                ,v_sur_name     varchar(64)
                                                ,v_date_birth   date
                                                ,v_locations_id int
                                                ,v_genders_id   smallint)
language plpgsql
as $$
/**********************************************************************
Процедура для изменения записи (игрока) в таблице players

Входные параметры:
  v_family       - фамилия
  v_name         - имя
  v_sur_name     - отчество
  v_date_birth   - дата рождения
  v_locations_id - идентификатор локации (locations.id)
  v_genders_id   - идентификатор пола (genders.id)
**********************************************************************/
begin
  v_id           := coalesce(v_id, 0);
  v_family       := coalesce(trim(v_family), '');
  v_name         := coalesce(trim(v_name), '');
  v_sur_name     := coalesce(trim(v_sur_name), '');
  v_locations_id := coalesce(v_locations_id, 0);
  v_genders_id   := coalesce(v_genders_id, 0);

  if not exists (select 1 
                   from players
                  where id = v_id) then
    raise exception 'Идентификатор игрока "%" не найден', v_id;
  end if;  

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

  update players
     set family       = v_family
        ,name         = v_name
        ,sur_name     = v_sur_name
        ,date_birth   = v_date_birth
        ,locations_id = v_locations_id
        ,genders_id   = v_genders_id
        ,users_id     = fnct_get_users_id(current_setting('ttsoftware.user_login', true))
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при обновлении записи в таблице players: %', sqlerrm;
end $$;

grant execute on procedure proc_update_players (int, varchar, varchar, varchar, date, int, smallint) to role_user
                                                                                                       ,role_org
                                                                                                       ,role_admin;
