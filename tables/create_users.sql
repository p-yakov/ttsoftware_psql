create table if not exists users (id       int         generated always as identity primary key --уникальный идентификатор таблицы
                                 ,login    varchar(64) not null
                                 ,password varchar(64) not null);
																 
create unique index if not exists idx_unq_users_login on users (login);

grant select
     ,insert on users to role_guest;

grant select
     ,update on users to role_user
                         ,role_org
                         ,role_admin;