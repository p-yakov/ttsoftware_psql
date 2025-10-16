create or replace procedure proc_update_users_roles (v_id          int
                                                    ,v_roles_id    smallint
                                                    ,v_date_action daterange)
language plpgsql
as $$
/**********************************************************************
Процедура для обновления записи в таблице users_roles

Входные параметры:
 v_id          - идентификатор записи (users_roles.id)
 v_roles_id    - идентификатор роли (roles.id)
 v_date_action - дата предоставления прав
**********************************************************************/
begin
  v_id          := coalesce(v_id, 0);
  v_roles_id    := coalesce(v_roles_id, 0);
  v_date_action := coalesce(v_date_action, 'empty'::daterange);

  if not exists (select 1 
                   from users_roles
                  where id = v_id) then
    raise exception 'Идентификатор связи пользователя с ролью "%" не найден', v_users_roles_id;
  end if;

  if not exists (select 1 
                   from roles 
                  where id = v_roles_id) then
    raise exception 'Роль с идентификатором "%" не найдена', v_roles_id;
  end if;

  if v_date_action = 'empty'::daterange then
    raise exception 'Не заданы даты предоставления прав';
  end if;

  update users_roles
     set roles_id    = v_roles_id
        ,date_action = v_date_action
        ,granted_at  = now()
        ,granted_by  = fnct_get_users_id(current_setting('ttsoftware.user_login', true))
   where id = v_id;
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу users_roles: %', sqlerrm;
end
$$;

grant execute on procedure proc_update_users_roles (int, smallint, daterange) to role_admin;