// SaveManager - Initialize save tracking globals
// This object is persistent and survives room changes

// Which save slot is currently active (0 = no slot, 1-3 = slot number)
if (!variable_global_exists("active_slot")) {
	global.active_slot = 0;
}

// Track opened chests: struct with chest_id as key, true/false as value
if (!variable_global_exists("chest_states")) {
	global.chest_states = {};
}

// Track destroyed doors: struct with door_id as key, true/false as value
if (!variable_global_exists("door_states")) {
	global.door_states = {};
}

// Gold coin system
if (!variable_global_exists("gold_coins")) {
	global.gold_coins = 0;
}
if (!variable_global_exists("enemy_lary_coins")) {
	global.enemy_lary_coins = 10;
}
if (!variable_global_exists("enemy_boss_lary_coins")) {
	global.enemy_boss_lary_coins = 50;
}
if (!variable_global_exists("enemy_roadboss_coins")) {
	global.enemy_roadboss_coins = 100;
}

show_debug_message("SaveManager initialized");
