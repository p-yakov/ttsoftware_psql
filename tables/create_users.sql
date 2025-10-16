create table if not exists users (id       int         generated always as identity --уникальный идентификатор таблицы
                                 ,login    varchar(32) not null                     --логин
                                 ,password char(60)    not null);                   --пароль
																 
create unique index if not exists idx_unq_users_id    on users (id);
create unique index if not exists idx_unq_users_login on users (login);

grant select on users to role_guest
                        ,role_user
                        ,role_org
                        ,role_admin;

grant insert on users to role_guest
                        ,role_admin;

grant update on users to role_user
                        ,role_org
                        ,role_admin;