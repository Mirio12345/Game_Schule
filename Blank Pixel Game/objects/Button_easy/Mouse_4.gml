event_inherited();
global.difficulity = 0;
//player
global.playerDMG = 25;
global.max_player_hp = 120;
global.playerSpeed = 2.5;
global.playerCooldown = 30;
//enimy lary
global.enemyDMG = 8;
global.enemyHP = 60;
global.enemySpeed = 2;
global.enemyCooldown = 60;
//enimy_roadboss
global.enimy_roadbossDMG = 10;
global.enimy_roadbossHP = 170;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 40;

try
{
if global.player_hp  >=  120
{
global.player_hp = 120;
}
}
catch(_error)
{
global.player_hp = 120;
}