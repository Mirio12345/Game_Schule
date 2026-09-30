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
if (!variable_global_exists("chest_ammo_reward_amount")) global.chest_ammo_reward_amount = 0;
if (!variable_global_exists("chest_ammo_reward_timer")) global.chest_ammo_reward_timer = 0;

// Track destroyed doors: struct with door_id as key, true/false as value
if (!variable_global_exists("door_states")) {
	global.door_states = {};
}

// Armor system (0 = none, 10/25/50/60 = % damage resistance)
if (!variable_global_exists("armor_level")) {
	global.armor_level = 0;
}
if (!variable_global_exists("max_player_armor")) {
	global.max_player_armor = 80;
}
if (!variable_global_exists("armorPerKit")) {
	global.armorPerKit = floor(global.max_player_armor * 0.5);
}
if (!variable_global_exists("player_armor")) {
	global.player_armor = 0;
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
global.weapon_sprites = [spr_weapon_usps, spr_weapon_glock, spr_weapon_makarov, spr_weapon_ak47];
global.weapon_sprite_scales = [0.14, 0.21, 0.23, 0.16];
global.weapon_shop_sprite_scales = [0.14, 0.21, 0.23, 0.16];
global.weapon_muzzle_offsets_x = [105, 54, 42, 123];
global.weapon_muzzle_offsets_y = [-45, -30, -24, -51];
global.weapon_hand_offset_x = 16.5;
global.weapon_hand_offset_y = 4;
global.weapon_dmg_mults = [1.0,       1.15,      1.20,      1.15];
global.weapon_spd_mults = [1.0,       1.0,       1.0,       0.65];
global.weapon_base_costs= [0,         175,       350,       600];
// Magazine and reserve ammo use the same weapon indexes as the shop arrays.
global.weapon_base_magazine_sizes = [12, 17, 8, 30];
global.weapon_magazine_sizes = [12, 17, 8, 30];
global.weapon_starting_reserve = [72, 102, 80, 180];
if (!variable_global_exists("weapon_ammo")) {
	global.weapon_ammo = [12, 17, 8, 30];
}
if (!variable_global_exists("weapon_reserve_ammo")) {
	global.weapon_reserve_ammo = [72, 102, 80, 180];
}
if (!variable_global_exists("weapon_upgrade_levels")) global.weapon_upgrade_levels = [0, 0, 0, 0];
if (!variable_global_exists("armor_upgrade_levels")) global.armor_upgrade_levels = [0, 0, 0, 0];
global.weapon_upgrade_costs = [150, 300, 550, 850];
global.armor_upgrade_costs = [125, 275, 500, 800];
global.weapon_upgrade_descriptions = [
	"Damage +10%.",
	"5% headshot chance and +5 rounds per magazine.",
	"Damage +25% total and 10% poison chance for 3 seconds.",
	"10% headshot chance, 15% poison chance, and +10 rounds per magazine total."
];
global.armor_upgrade_descriptions = [
	"Damage resistance +5%.",
	"Damage resistance +10% total and 5% bullet reflection chance.",
	"Damage resistance +15% total, +20 max HP, and +10% movement speed.",
	"Damage resistance +20% total and 10% bullet reflection chance."
];
if (!variable_global_exists("base_max_player_hp")) {
	global.base_max_player_hp = variable_global_exists("max_player_hp") ? global.max_player_hp : 100;
}
if (!variable_global_exists("max_player_hp")) global.max_player_hp = global.base_max_player_hp;
if (!variable_global_exists("armor_mirror_chance")) global.armor_mirror_chance = 0;
if (!variable_global_exists("armor_speed_bonus")) global.armor_speed_bonus = 0;
scr_sync_weapon_magazine_sizes();

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
