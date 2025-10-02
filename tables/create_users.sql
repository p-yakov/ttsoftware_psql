create table if not exists users (id 			 int  generated always as identity primary key
																 ,login 	 text not null
																 ,password text not null);
																 
create unique index if not exists "XIEusers" on users (login);

grant select, insert on users to role_guest;