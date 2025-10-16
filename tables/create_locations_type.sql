create table if not exists locations_type (id    smallint    generated always as identity --уникальынй идентификатор таблицы
                                          ,brief varchar(16) not null                     --сокращенное наименование
                                          ,name  varchar(64) not null);                   --полное наименование
                                          
create unique index if not exists idx_unq_locations_type on locations_type (id) include (brief, name);

grant select on locations_type to role_user
                                 ,role_org
                                 ,role_admin;