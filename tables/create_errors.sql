create table if not exists errors (code         int           generated always as identity primary key --уникальный идентификатор таблицы (код ошибки)
                                  ,message      text          not null                                 --сообщения об ошибке
                                  ,process_name varchar(64)[] not null);                               --массив процессов где указан code
                                  
create index if not exists idx_errors_process_name on errors using gin(process_name);

grant select on errors to role_guest
                         ,role_user
                         ,role_org
                         ,role_admin;