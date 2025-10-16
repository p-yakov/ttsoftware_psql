create table if not exists players (id           int         generated always as identity --уникальный идентификатор таблицы
                                   ,family       varchar(64) not null                     --фамилия
                                   ,name         varchar(64) not null                     --имя
                                   ,sur_name     varchar(64) not null                     --отчество
                                   ,date_birth   date        not null                     --дата рождения
                                   ,locations_id int         not null                     --идентификатор локации (locations.id)
                                   ,genders_id   smallint    not null                     --идентификатор пола (genders.id)
                                   ,users_id     int         not null                     --идентификатор пользователя (users.id)
                                   ,granted_at   timestamptz not null default(now()));    --дата создания/зименения записи

create unique index if not exists idx_unq_players_id     on players (id);
create        index if not exists idx_unq_players_fnsdlg on players (family, name, sur_name, date_birth, locations_id, genders_id);

grant select
     ,insert
     ,update on players to role_user
                          ,role_org
                          ,role_admin;