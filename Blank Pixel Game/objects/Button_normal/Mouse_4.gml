event_inherited();
global.difficulity = 1;
//player
global.playerDMG = 20;
global.max_player_hp = 100;
global.playerSpeed = 2.25;
global.playerShootCooldown = 30;
global.playerReflectCooldown = 30;
global.HealValue = global.max_player_hp / 2;
global.HealitemCount = 2;
global.MaxHealitemCount = 2;
global.HealCooldown = 300;
//enimy lary
global.enemyDMG = 15;
global.enemyHP = 70;
global.enemySpeed = 2.8;
global.enemyCooldown = 45;
//enimy_roadboss
global.enimy_roadbossDMG = 18;
global.enimy_roadbossHP = 300;
global.enimy_roadbossSpeed = 1;
global.enimy_roadbossCooldown = 20;
//enemy_boss_lary
global.enemy_boss_lary_DMG = 8;
global.enemy_boss_lary_HP = 50;
global.enemy_boss_lary_Speed = 1.8;
global.enemy_boss_lary_Cooldown = 60;

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