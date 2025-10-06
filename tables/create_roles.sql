create table if not exists roles (id   int  generated always as identity primary key --уникальный идентификатор таблицы
                                 ,name text not null);

create unique index if not exists idx_unq_roles_name on roles (name);
                                 
grant select on roles to role_guest
                        ,role_user
                        ,role_org
                        ,role_admin;