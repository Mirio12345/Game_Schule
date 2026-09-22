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

// Armor system (0 = none, 10/25/50/60 = % damage resistance)
if (!variable_global_exists("armor_level")) {
	global.armor_level = 0;
}

// Armor ownership and equip (parallel arrays, must match BAZAR shop)
if (!variable_global_exists("owned_armors")) {
	// [Cloth, Leather, Iron, Diamond] - none owned by default
	global.owned_armors = [false, false, false, false];
}
if (!variable_global_exists("current_armor")) {
	global.current_armor = -1; // -1 = no armor equipped
}

// Weapon system
if (!variable_global_exists("owned_weapons")) {
	global.owned_weapons = [true, false, false, false]; // [USP-S, Glock, Makarov, AK-47] - start with USP-S
}
if (!variable_global_exists("current_weapon")) {
	global.current_weapon = 0; // index into weapon list (USP-S)
}

// Exponential pricing: each purchase increases future prices
if (!variable_global_exists("total_purchases")) {
	global.total_purchases = 0;
}

// Armor data (must match BAZAR shop)
global.armor_names     = ["Cloth Armor",  "Leather Armor", "Iron Armor",  "Diamond Armor"];
global.armor_resists   = [10,             25,              50,            60];
global.armor_base_costs= [50,             150,             400,           800];

// Weapon data (must match BAZAR shop)
global.weapon_names     = ["USP-S",   "Glock",   "Makarov", "AK-47"];
global.weapon_dmg_mults = [1.0,       1.15,      1.20,      1.15];
global.weapon_spd_mults = [1.0,       1.0,       1.0,       0.65];
global.weapon_base_costs= [0,         175,       350,       600];

// Item data (cigarettes / consumables - press E to smoke)
global.item_names      = ["Cigarette",       "Green Cigarette"];
global.item_descs      = ["Standard Smoke",  "+20% Move Speed (10s)"];
global.item_speed_mults= [1.0,               1.2];
global.item_base_costs = [50,                 250];
if (!variable_global_exists("item_counts")) {
	global.item_counts = [0, 0]; // how many of each cigarette you own
}
if (!variable_global_exists("speed_boost_timer")) {
	global.speed_boost_timer = 0; // frames remaining on speed boost
}
if (!variable_global_exists("item_cooldown")) {
	global.item_cooldown = 0; // frames until next smoke allowed
}

// Price exponent - higher = steeper exponential curve
global.price_exponent   = 1.6;

// Sync armor level on init
scr_sync_armor_level();

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
