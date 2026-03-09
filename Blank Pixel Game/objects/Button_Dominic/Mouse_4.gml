event_inherited();
global.difficulity = 3;
//player
global.playerDMG = 10;
global.max_player_hp = 60;
global.playerSpeed = 1.8;
global.playerCooldown = 60;
//enimy lary
global.enemyDMG = 20;
global.enemyHP = 150;
global.enemySpeed = 3;
global.enemyCooldown = 20;
//enimy_roadboss
global.enimy_roadbossDMG = 30;
global.enimy_roadbossHP = 600;
global.enimy_roadbossSpeed = 5;
global.enimy_roadbossCooldown = 5;

try
{
if global.player_hp  >=  60
{
global.player_hp = 60;
}
}
catch(_error)
{
global.player_hp = 60;
}