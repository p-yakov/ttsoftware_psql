create table if not exists genders (id    smallint   generated always as identity
                                   ,brief char(1)    not null
                                   ,name  varchar(8) not null);

create unique index if not exists idx_unq_genders_id on genders (id) include (brief, name);

grant select on genders to role_guest
                          ,role_user
                          ,role_org
                          ,role_admin;