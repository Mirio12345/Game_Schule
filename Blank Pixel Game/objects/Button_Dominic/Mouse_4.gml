event_inherited();
global.difficulity = 3;
//player
global.playerDMG = 10;
global.max_player_hp = 100;
global.playerSpeed = 2.25;
global.playerShootCooldown = 60;
global.HealValue = global.max_player_hp / 2;
global.HealitemCount = 1;
global.MaxHealitemCount = 1;
global.HealCooldown = 300;
//enimy lary
global.enemyDMG = 34;
global.enemyHP = 150;
global.enemySpeed = 2.8;
global.enemyCooldown = 20;
//enimy_roadboss
global.enimy_roadbossDMG = 100;
global.enimy_roadbossHP = 600;
global.enimy_roadbossSpeed = 5;
global.enimy_roadbossCooldown = 5;

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