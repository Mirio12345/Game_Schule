event_inherited();
global.difficulity = 3;
global.playerDMG = 10;
global.max_player_hp = 60;
global.playerSpeed = 1.8;
global.playerCooldown = 60;
global.enemyDMG = 20;
global.enemyHP = 150;
global.enemySpeed = 3;
global.enemyCooldown = 20;
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