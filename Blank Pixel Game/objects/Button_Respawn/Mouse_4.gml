event_inherited();

global.player_hp = global.max_player_hp;
global.HealitemCount = global.MaxHealitemCount;
global.player_armor = 0; // Rüstung geht beim Tod verloren, muss neu gefunden werden

// Checkpoint -> Position/Ziel-Room als switch statt sechs unabhängiger ifs,
// die sich ohnehin gegenseitig ausschließen (nur der passende Fall wird
// jetzt geprüft, statt immer alle sechs). Der leere "checkpoint == 0"-Block
// und der auskommentierte, ungenutzte difficulty-Codeblock wurden entfernt.
switch (global.latest_checkpoint) {
	case 1:
		// !SCRAPED!
		global.Pos_x = 550;
		global.Pos_y = 360;
		room_goto(TestRoom);
		break;

	case 2:
		// !SCRAPED!
		global.Pos_x = 700;
		global.Pos_y = 340;
		room_goto(lausgang);
		break;

	case 3:
		global.Pos_x = 333;
		global.Pos_y = 237;
		global.curent_room = Startroom_battle;
		room_goto(Startroom_battle);
		break;

	case 4:
		global.Pos_x = 773;
		global.Pos_y = 678;
		global.curent_room = Battle1;
		room_goto(Battle1);
		break;

	case 5:
		global.Pos_x = 1121;
		global.Pos_y = 644;
		global.curent_room = Battle2;
		room_goto(Battle2);
		break;
}
