my_speed = 2.5;
shoot_cooldown = global.playerShootCooldown;   // Wie lange er zwischen Schüssen wartet (60 Frames = ca. 1 Sekunde)
drink_cooldown = global.HealCooldown;
can_shoot = true;
can_heal = true;
try 
{
	hp = global.player_hp;
	Pos_x = global.Pos_x;
	Pos_y = global.Pos_y;
}
catch(_error)
{
	global.player_hp = global.max_player_hp;
	global.Pos_x = 353;
	global.Pos_y = 255;
	global.latest_checkpoint = 3;
}

x = Pos_x;
y = Pos_y;
