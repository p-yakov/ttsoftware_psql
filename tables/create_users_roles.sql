create table if not exists users_roles (id         int         generated always as identity primary key --уникальный идентификатор таблицы
                                       ,users_id   int         not null                                 --идентификатор пользователя (users.id)
                                       ,roles_id   int         not null                                 --идентификатор роли (roles.id)
                                       ,granted_at timestamptz default now()                            --дата предоставления прав
                                       ,granted_by int         not null);                               --идентификатор пользователя предоставивший права

create index if not exists idx_users_roles_users_id on users_roles (users_id);
create index if not exists idx_users_roles_roles_id on users_roles (roles_id);
create index if not exists idx_unq_users_roles on users_roles (users_id, roles_id);

grant select on roles to role_guest
                        ,role_user
                        ,role_org;
                        
grant select
     ,insert
     ,update on roles to role_admin;