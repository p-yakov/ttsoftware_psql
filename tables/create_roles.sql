create table if not exists roles (id   smallint    generated always as identity --уникальный идентификатор таблицы
                                 ,name varchar(16) not null);                   --наименование
                                 
create unique index if not exists idx_unq_roles_id   on roles (id);
create unique index if not exists idx_unq_roles_name on roles (name);
                                 
grant select on roles to role_guest
                        ,role_user
                        ,role_org
                        ,role_admin;