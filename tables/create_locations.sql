create table if not exists locations (id                int          generated always as identity --уникальный идентификатор таблицы
                                     ,name	            varchar(128) not null                     --наименование
                                     ,parent_id         int          not null                     --идентификатор родителя
                                     ,locations_type_id smallint     not null);                   --идентификатор типа (locations_type.id)

create unique index if not exists idx_unq_locations_id on locations (id);

grant select on locations to role_user
                            ,role_org
                            ,role_admin;