create or replace function fnct_trg_players()
returns trigger
language plpgsql
as $$
begin
  if tg_op = 'INSERT' then
    insert into hist_players (operation
                             ,players_id
                             ,family
                             ,name
                             ,sur_name
                             ,date_birth
                             ,locations_id
                             ,genders_id
                             ,users_id
                             ,granted_at)
    values ('I'
           ,new.players_id
           ,new.family
           ,new.name
           ,new.sur_name
           ,new.date_birth
           ,new.locations_id
           ,new.genders_id
           ,new.users_id
           ,new.granted_at);

    return new;
  end if;

  if tg_op = 'UPDATE' then
   insert into hist_players (operation
                             ,players_id
                             ,family
                             ,name
                             ,sur_name
                             ,date_birth
                             ,locations_id
                             ,genders_id
                             ,users_id
                             ,granted_at)
    values ('U'
           ,old.players_id
           ,old.family
           ,old.name
           ,old.sur_name
           ,old.date_birth
           ,old.locations_id
           ,old.genders_id
           ,old.users_id
           ,old.granted_at);

    return old;
  end if;

  if tg_op = 'DELETE' then
    insert into hist_players (operation
                             ,players_id
                             ,family
                             ,name
                             ,sur_name
                             ,date_birth
                             ,locations_id
                             ,genders_id
                             ,users_id
                             ,granted_at)
    values ('D'
           ,old.players_id
           ,old.family
           ,old.name
           ,old.sur_name
           ,old.date_birth
           ,old.locations_id
           ,old.genders_id
           ,old.users_id
           ,old.granted_at);

    return old;
  end if;

  return null;
end
$$;