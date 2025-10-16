create or replace trigger trg_players
after insert or update or delete on players 
for each row
execute function fnct_trg_players();