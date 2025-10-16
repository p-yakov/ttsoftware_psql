create table if not exists hist_users_roles (id             int         generated always as identity               --уникальный идентификатор таблицы
                                            ,operation      char(1)     not null check(operation in ('I','U','D')) --тип операции (I - insert, U - update, D - delete)
                                            ,users_roles_id int         not null                                   --идентификатор связи пользователя с ролью (users_roles.id)
                                            ,users_id       int         not null                                   --идентификатор пользователя (users.id)
                                            ,roles_id       smallint    not null                                   --идентификатор роли (roles.id)
                                            ,date_action    daterange   not null                                   --дата начала/окончания действия прав
                                            ,granted_at     timestamptz not null                                   --дата предоставления прав
                                            ,granted_by     int         not null);                                 --идентификатор пользователя предоставивший права

create unique index if not exists idx_unq_hist_users_roles_id on hist_users_roles (id);
create        index if not exists idx_hist_users_roles        on hist_users_roles (users_roles_id);