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
	global.playerSpeed = 2.5;
	global.playerCooldown = 30;
	//enimy lary
	global.enemyDMG = 10;
	global.enemyHP = 70;
	global.enemySpeed = 2;
	global.enemyCooldown = 60;
	//enimy boss
	global.enimy_roadbossDMG = 15;
	global.enimy_roadbossHP = 300;
	global.enimy_roadbossSpeed = 1;
	global.enimy_roadbossCooldown = 20;

	global.curent_room = Startroom_battle;

	room_goto(global.curent_room);
}