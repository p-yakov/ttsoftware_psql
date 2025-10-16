create or replace procedure proc_insert_users_roles (v_users_id    int
                                                    ,v_roles_id    smallint
                                                    ,v_date_action daterange)
language plpgsql
as $$
/**********************************************************************
Процедура для вставки записи в таблицу users_roles

Входные параметры:
 v_users_id    - идентификатор пользователя (users.id)
 v_roles_id    - идентификатор роли (roles.id)
 v_date_action - дата предоставления прав
**********************************************************************/
begin
  v_users_id    := coalesce(v_users_id, 0);
  v_roles_id    := coalesce(v_roles_id, 0);
  v_date_action := coalesce(v_date_action, 'empty'::daterange);

  if not exists (select 1 
                   from users 
                  where id = v_users_id) then
    raise exception 'Пользователь с идентификатором "%" не найден', v_users_id;
  end if;

  if not exists (select 1 
                   from roles 
                  where id = v_roles_id) then
    raise exception 'Роль с идентификатором "%" не найдена', v_roles_id;
  end if;

  if v_date_action = 'empty'::daterange then
    raise exception 'Не заданы даты предоставления прав';
  end if;

  if exists (select 1 
               from users_roles 
              where users_id = v_users_id) then
    raise exception 'Пользователь с идентификатором "%" уже входит в роль', v_users_id;
  end if;

  insert into users_roles (users_id
                          ,roles_id
                          ,date_action
                          ,granted_by)
  values (v_users_id
         ,v_roles_id
         ,v_date_action
         ,fnct_get_users_id(current_setting('ttsoftware.user_login', true)));
exception 
  when others then raise exception 'Ошибка при добавлении записи в таблицу users_roles: %', sqlerrm;
end
$$;

grant execute on procedure proc_insert_users_roles (int, smallint, daterange) to role_admin;