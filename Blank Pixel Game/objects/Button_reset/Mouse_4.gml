event_inherited();

if (variable_global_exists("curent_room")) {
	global.player_hp = -10;
	room_goto(global.curent_room);
} else {
	show_debug_message("Reset Before start");
}
