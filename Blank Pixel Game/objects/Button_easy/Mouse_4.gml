event_inherited();
global.difficulity = 0;
global.playerDMG = 25;
global.max_player_hp = 120;
global.playerSpeed = 2.5;
global.playerCooldown = 30;
global.enemyDMG = 8;
global.enemyHP = 60;
global.enemySpeed = 2;
global.enemyCooldown = 60;
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