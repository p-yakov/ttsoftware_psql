create or replace function fnct_trg_users_roles()
returns trigger
language plpgsql
as $$
begin
  if tg_op = 'INSERT' then
    insert into hist_users_roles (operation
                                 ,users_roles_id
                                 ,users_id
                                 ,roles_id
                                 ,date_action
                                 ,granted_at
                                 ,granted_by)
    values ('I'
           ,new.users_roles_id
           ,new.users_id
           ,new.roles_id
           ,new.date_action
           ,new.granted_at
           ,new.granted_by);

    return new;
  end if;

  if tg_op = 'UPDATE' then
    insert into hist_users_roles (operation
                                 ,users_roles_id
                                 ,users_id
                                 ,roles_id
                                 ,date_action
                                 ,granted_at
                                 ,granted_by)
    values ('U'
           ,old.users_roles_id
           ,old.users_id
           ,old.roles_id
           ,old.date_action
           ,old.granted_at
           ,old.granted_by);

    return old;
  end if;

  if tg_op = 'DELETE' then
    insert into hist_users_roles (operation
                                 ,users_roles_id
                                 ,users_id
                                 ,roles_id
                                 ,date_action
                                 ,granted_at
                                 ,granted_by)
    values ('D'
           ,old.users_roles_id
           ,old.users_id
           ,old.roles_id
           ,old.date_action
           ,old.granted_at
           ,old.granted_by);

    return old;
  end if;

  return null;
end
$$;