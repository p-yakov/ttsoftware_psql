drop table if exists temp_roles;

create temp table temp_roles (id   smallint    generated always as identity
                             ,name varchar(16) not null);

create unique index idx_unq_temp_roles on temp_roles (id);

insert into temp_roles (name)
values ('guest')
      ,('user')
      ,('org')
      ,('admin');

do $$
  declare r record;
begin
  for r in select id
                 ,name
             from temp_roles 
            order by id
  loop
    begin
      call proc_insert_roles (r.name);
      exception 
        when others then raise warning 'Ошибка по записи id = %; name = %: %', r.id, r.name, sqlerrm;
    end;    
  end loop;
end
$$;