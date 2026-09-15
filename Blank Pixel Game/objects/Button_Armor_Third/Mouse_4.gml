event_inherited();
if (!variable_global_exists("max_player_armor")) apply_difficulty(1, true);
global.player_armor = min(global.max_player_armor, global.player_armor + global.max_player_armor * (1.0 / 3.0));
