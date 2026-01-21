my_speed = 2.5;
try 
{
	hp = global.player_hp;
	Pos_x = global.Pos_x;
	Pos_y = global.Pos_y;
}
catch(_error)
{
	global.player_hp = 100;
	global.max_player_hp = 100;
	global.Pos_x = 825;
	global.Pos_y = 340;
	global.latest_checkpoint = 1;
}

x = Pos_x;
y = Pos_y;
