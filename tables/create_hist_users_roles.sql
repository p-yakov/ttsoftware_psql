create table if not exists hist_users_roles (id             int         generated always as identity primary key   --уникальный идентификатор таблицы
                                            ,operation      char(1)     not null check(operation in ('I','U','D')) --тип операции (I - insert, U - update, D - delete)
                                            ,users_roles_id int         not null                                   --идентификатор связи пользователя с ролью (users_roles.id)
                                            ,users_id       int         not null
                                            ,roles_id       int         not null
                                            ,granted_at     timestamptz not null
                                            ,granted_by     int         not null);

create index if not exists idx_hist_users_roles on hist_users_roles (users_roles_id);