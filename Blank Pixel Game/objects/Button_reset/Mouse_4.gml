event_inherited()
try
{
global.player_hp = -10
room_goto(global.curent_room)
}
catch(_error)
{
show_debug_message("Reset Before start");
}