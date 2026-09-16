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

show_debug_message("SaveManager initialized");
