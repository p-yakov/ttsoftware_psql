create table if not exists errors (code         int           not null   --код ошибки
                                  ,message      text          not null   --сообщения об ошибке
                                  ,process_name varchar(64)[] not null); --массив процессов где указан code
                                  
create unique index if not exists idx_unq_errors on errors (code);
create        index if not exists idx_errors     on errors using gin(process_name);

grant select on errors to role_guest
                         ,role_user
                         ,role_org
                         ,role_admin;