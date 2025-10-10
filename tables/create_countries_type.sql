create table if not exists countries_type (id   int         generated always as identity --уникальынй идентификатор таблицы
                                          ,name varchar(64) not null);                   --наименование типа
                                          
create unique index if not exists idx_unq_countries_type on countries_type (name) include (id);

grant select on countries_type to role_user
                                 ,role_org;

grant select
     ,insert
     ,update on countries_type to role_admin;