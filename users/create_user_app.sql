do $$
	begin
		if not exists (select 1 
                     from pg_roles 
                    where rolname = 'user_app') then
			create role user_app login;

			if exists (select 1 
                   from pg_roles 
                  where rolname = 'role_guest') then
				grant role_guest to user_app;
			end if;
		end if;
	end
$$;