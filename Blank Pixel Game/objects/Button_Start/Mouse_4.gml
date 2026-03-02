event_inherited();
try
{
	room_goto(global.curent_room);
}
catch(_error)
{
	global.curent_room = Startroom_battle;
	room_goto(global.curent_room);
}