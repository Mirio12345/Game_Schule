event_inherited();
global.difficulity = 1;
//player
global.playerDMG = 20;
global.max_player_hp = 100;
global.playerSpeed = 2.5;
global.playerCooldown = 32;
global.HealValue = global.max_player_hp / 2;
//enimy lary
global.enemyDMG = 12;
global.enemyHP = 70;
global.enemySpeed = 2.15;
global.enemyCooldown = 55;
//enimy_roadboss
global.enimy_roadbossDMG = 15;
global.enimy_roadbossHP = 300;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 20;
try
{
if global.player_hp  >=  100
{
global.player_hp = 100;
}
}
catch(_error)
{
global.player_hp = 100;
}