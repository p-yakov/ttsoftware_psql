create or replace trigger trg_users_roles
after insert or update or delete on users_roles 
for each row
execute function fnct_trg_users_roles();