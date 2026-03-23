event_inherited();
try
{
	room_goto(global.curent_room);
}
catch(_error)
{
	global.difficulity = 1;
	//player
	global.player_hp = 100;
	global.playerDMG = 20;
	global.max_player_hp = 100;
	global.playerSpeed = 2.25;
	global.playerShootCooldown = 30;
	global.HealValue = global.max_player_hp / 2;
	global.HealMultiplier = 1;
	global.HealitemCount = 2;
	global.MaxHealitemCount = 2;
	global.HealCooldown = 300;
	//enemy lary
	global.enemyDMG = 15;
	global.enemyHP = 70;
	global.enemySpeed = 2.8;
	global.enemyCooldown = 45;
	//enemy boss
	global.enimy_roadbossDMG = 15;
	global.enimy_roadbossHP = 300;
	global.enimy_roadbossSpeed = 1;
	global.enimy_roadbossCooldown = 20;

	global.curent_room = Startroom_battle;

	room_goto(global.curent_room);
}