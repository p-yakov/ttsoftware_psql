create table if not exists hist_players (id           int         generated always as identity               --уникальный идентификатор таблицы
                                        ,operation    char(1)     not null check(operation in ('I','U','D')) --тип операции (I - insert, U - update, D - delete)
                                        ,players_id   int         not null                                   --идентификатор игрока
                                        ,family       varchar(64) not null                                   --фамилия
                                        ,name         varchar(64) not null                                   --имя
                                        ,sur_name     varchar(64) not null                                   --отчество
                                        ,date_birth   date        not null                                   --дата рождения
                                        ,locations_id int         not null                                   --идентификатор локации (locations.id)
                                        ,genders_id   smallint    not null                                   --идентификатор пола (genders.id)
                                        ,users_id     int         not null                                   --идентификатор пользователя (users.id)
                                        ,granted_at   timestamptz not null default(now()));                  --дата создания/зименения записи
                          
create unique index if not exists idx_unq_hist_players on hist_players (id);