create table if not exists countries (id        int  generated always as identity primary key --уникальный идентификатор таблицы
                                     ,name	    text not null                                 --наименование
                                     ,parent_id int  not null);                               --идентификатор родителя

create index if not exists idx_countries_parent_id on countries (parent_id) include (name);

grant select on countries to role_user
                            ,role_org;
grant select
     ,insert
     ,update on countries to role_admin;