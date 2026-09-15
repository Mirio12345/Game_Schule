event_inherited();

// Erststart: falls noch kein Spiel initialisiert wurde, mit Normal-Difficulty
// als Default aufsetzen (entspricht dem alten try/catch-Verhalten).
if (!variable_global_exists("curent_room")) {
	apply_difficulty(1, true);
	global.curent_room = Startroom_battle;
}

room_goto(global.curent_room);
