event_inherited();
global.difficulity = 2;
//player 
global.playerDMG = 15;
global.max_player_hp = 100;
global.playerSpeed = 2.25;
global.playerShootCooldown = 40;
global.HealValue = global.max_player_hp / 2;
global.HealitemCount = 2;
global.MaxHealitemCount = 2;
global.HealCooldown =300;
//enimy lary
global.enemyDMG = 20;
global.enemyHP = 100;
global.enemySpeed = 2.8;
global.enemyCooldown = 40;
//enimy_roadboss
global.enimy_roadbossDMG = 25;
global.enimy_roadbossHP = 350;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 10;

if global.player_hp  >=  100
{
global.player_hp = 100;
}