do $$
	begin
		if not exists (select 1 
                     from pg_roles 
                    where rolname = 'role_admin') then
			create role role_admin;

			if exists (select 1 
                   from pg_database 
                  where datname = 'ttsoftware') 
				and exists (select 1 
                      from pg_roles 
                     where rolname = 'role_admin') then
				grant connect on database ttsoftware to role_admin;
			end if;
		end if;
	end
$$;