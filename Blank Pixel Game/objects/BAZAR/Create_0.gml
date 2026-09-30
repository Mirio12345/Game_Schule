// Bazaar NPC interaction and dialogue state.
interact_range = 60;

// Support rooms started directly in the editor without visiting difficulty selection.
if (!variable_global_exists("max_player_armor")) global.max_player_armor = 80;
if (!variable_global_exists("armorPerKit")) global.armorPerKit = floor(global.max_player_armor * 0.5);
if (!variable_global_exists("player_armor")) global.player_armor = 0;
if (!variable_global_exists("owned_armors")) global.owned_armors = [false, false, false, false];
if (!variable_global_exists("current_armor")) global.current_armor = -1;
if (!variable_global_exists("armor_names")) global.armor_names = ["Cloth Armor", "Leather Armor", "Iron Armor", "Diamond Armor"];
if (!variable_global_exists("armor_resists")) global.armor_resists = [10, 25, 50, 60];
if (!variable_global_exists("armor_base_costs")) global.armor_base_costs = [50, 150, 400, 800];
if (!variable_global_exists("armor_level")) global.armor_level = 0;
if (!variable_global_exists("weapon_upgrade_levels")) global.weapon_upgrade_levels = [0, 0, 0, 0];
if (!variable_global_exists("armor_upgrade_levels")) global.armor_upgrade_levels = [0, 0, 0, 0];
if (!variable_global_exists("weapon_base_magazine_sizes")) global.weapon_base_magazine_sizes = [12, 17, 8, 30];
if (!variable_global_exists("weapon_magazine_sizes")) global.weapon_magazine_sizes = [12, 17, 8, 30];
if (!variable_global_exists("weapon_starting_reserve")) global.weapon_starting_reserve = [72, 102, 80, 180];
if (!variable_global_exists("weapon_ammo")) global.weapon_ammo = [12, 17, 8, 30];
if (!variable_global_exists("weapon_reserve_ammo")) global.weapon_reserve_ammo = [72, 102, 80, 180];
if (!variable_global_exists("weapon_upgrade_costs")) global.weapon_upgrade_costs = [150, 300, 550, 850];
if (!variable_global_exists("armor_upgrade_costs")) global.armor_upgrade_costs = [125, 275, 500, 800];
if (!variable_global_exists("weapon_upgrade_descriptions")) global.weapon_upgrade_descriptions = ["Damage +10%.", "5% headshot chance and +5 rounds per magazine.", "Damage +25% total and 10% poison chance for 3 seconds.", "10% headshot chance, 15% poison chance, and +10 rounds per magazine total."];
if (!variable_global_exists("armor_upgrade_descriptions")) global.armor_upgrade_descriptions = ["Damage resistance +5%.", "Damage resistance +10% total and 5% bullet reflection chance.", "Damage resistance +15% total, +20 max HP, and +10% movement speed.", "Damage resistance +20% total and 10% bullet reflection chance."];
scr_sync_weapon_magazine_sizes();
scr_sync_armor_level();

chat_open = false;
chat_page = 0;
chat_alpha = 0;
chat_target_alpha = 0;

chat_lines = [
	"Welcome, traveler. Need some gear?",
	"Yes. I need a stronger weapon.",
	"I sell weapons, armor, upgrades and repair kits.",
	"Great. Let me see your stock.",
];
chat_speakers = ["BAZARMEN", "PLAYER", "BAZARMEN", "PLAYER"];
chat_total = array_length(chat_lines);

typewriter_pos = 0;
typewriter_speed = 0.6;
typewriter_done = false;

// Shop screens: 0 = closed, 1 = categories, 2 = weapons/ammo, 3 = armor/repair, 4 = upgrades.
shop_open = false;
shop_screen = 0;
shop_selected = 0;
armor_kit_base_cost = 50;
ammo_pack_base_cost = 50;
shop_message = "";
shop_message_timer = 0;
shop_message_color = c_white;
shop_anim_time = 0;
shop_select_pulse = 0;
shop_input_mode = "keyboard";
shop_last_mouse_x = -10000;
shop_last_mouse_y = -10000;

// Wander calmly through the room, stopping while the player talks or shops.
wander_speed = 1.25;
wander_margin = 96;
wander_pause_timer = irandom_range(30, 90);
wander_stuck_timer = 0;
wander_target_x = clamp(x + irandom_range(-240, 240), wander_margin, max(wander_margin, room_width - wander_margin));
wander_target_y = clamp(y + irandom_range(-180, 180), wander_margin, max(wander_margin, room_height - wander_margin));
