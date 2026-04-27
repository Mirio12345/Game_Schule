event_inherited();
global.difficulity = 0;
//player
global.playerDMG = 25;
global.max_player_hp = 100;
global.playerSpeed = 2.25;
global.playerShootCooldown = 30;
global.HealValue = global.max_player_hp / 1;
global.HealitemCount = 3;
global.MaxHealitemCount = 3;
global.HealCooldown =300;
//enimy lary
global.enemyDMG = 10;
global.enemyHP = 60;
global.enemySpeed = 2.8;
global.enemyCooldown = 60;
//enimy_roadboss
global.enimy_roadbossDMG = 15;
global.enimy_roadbossHP = 200;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 40;

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