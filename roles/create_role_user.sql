do $$
	begin
		if not exists (select 1 
                     from pg_roles 
                    where rolname = 'role_user') then
			create role role_user;

			if exists (select 1 
                   from pg_database
                  where datname = 'ttsoftware') 
				and exists (select 1 
                      from pg_roles 
                     where rolname = 'role_user') then
				grant connect on database ttsoftware to role_user;
			end if;
		end if;
	end
$$;