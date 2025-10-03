create table if not exists users (id       int  generated always as identity primary key --уникальный идентификатор таблицы
                                 ,login    text not null
                                 ,password text not null);
																 
create unique index if not exists idx_unq_users on users (login);

grant select, insert on users to role_guest;