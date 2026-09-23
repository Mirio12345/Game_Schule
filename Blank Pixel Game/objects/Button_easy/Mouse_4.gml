event_inherited();
global.difficulity = 0;
//player
global.playerDMG = 25;
global.max_player_hp = 100;
global.playerSpeed = 2.25;
global.playerShootCooldown = 30;
global.playerReflectCooldown = 30;
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
global.enimy_roadbossHP = 295;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 40;
//enemy_boss_lary
global.enemy_boss_lary_DMG = 5;
global.enemy_boss_lary_HP = 30;
global.enemy_boss_lary_Speed = 1.0;
global.enemy_boss_lary_Cooldown = 80;

global.bulletSpeed = 10;
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