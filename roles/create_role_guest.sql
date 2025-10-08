do $$
	begin
		if not exists (select 1 
                     from pg_roles 
                    where rolname = 'role_guest') then
			create role role_guest;

			if exists (select 1 
                   from pg_database 
                  where datname = 'ttsoftware') 
				and exists (select 1 
                      from pg_roles 
                     where rolname = 'role_guest') then
				grant connect on database ttsoftware to role_guest;
			end if;
		end if;
	end
$$;