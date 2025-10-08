do $$
	begin
		if not exists (select 1 
                     from pg_roles 
                    where rolname = 'role_org') then
			create role role_org;

			if exists (select 1 
                   from pg_database 
                  where datname = 'ttsoftware')
				and exists (select 1 
                      from pg_roles 
                     where rolname = 'role_org') then
				grant connect on database ttsoftware to role_org;
			end if;
		end if;
	end
$$;