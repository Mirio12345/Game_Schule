event_inherited();
try
{
	room_goto(global.curent_room);
}
catch(_error)
{
	global.difficulity = 1;
	global.playerDMG = 20;
global.max_player_hp = 100;
global.playerSpeed = 2.5;
global.playerCooldown = 30;
global.enemyDMG = 10;
global.enemyHP = 70;
global.enemySpeed = 2;
global.enemyCooldown = 60;
	global.curent_room = Startroom_battle;
	global.player_hp = 100;
	room_goto(global.curent_room);
}