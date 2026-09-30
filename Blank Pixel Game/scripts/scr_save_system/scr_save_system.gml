/// @function scr_save_game(slot)
/// @description Saves the current game state to a JSON file
/// @param {real} slot The save slot number (1, 2, or 3)
/// @returns {bool} true on success, false on failure
function scr_save_game(slot) {
	if (slot < 1 || slot > 3) return false;
	
	var _data = {
		// Player state
		player_hp:             global.player_hp,
		max_player_hp:         global.max_player_hp,
		base_max_player_hp:    global.base_max_player_hp,
		Pos_x:                 global.Pos_x,
		Pos_y:                 global.Pos_y,
		latest_checkpoint:     global.latest_checkpoint,
		curent_room:           global.curent_room,
		
		// Player stats
		playerDMG:             global.playerDMG,
		playerSpeed:           global.playerSpeed,
		playerShootCooldown:   global.playerShootCooldown,
		playerReflectCooldown: global.playerReflectCooldown,
		HealValue:             global.HealValue,
		HealMultiplier:        global.HealMultiplier,
		HealitemCount:         global.HealitemCount,
		MaxHealitemCount:      global.MaxHealitemCount,
		HealCooldown:          global.HealCooldown,
		
		// Difficulty
		difficulity:           global.difficulity,
		
		// Enemy stats
		enemyDMG:              global.enemyDMG,
		enemyHP:               global.enemyHP,
		enemySpeed:            global.enemySpeed,
		enemyCooldown:         global.enemyCooldown,
		enimy_roadbossDMG:     global.enimy_roadbossDMG,
		enimy_roadbossHP:      global.enimy_roadbossHP,
		enimy_roadbossSpeed:   global.enimy_roadbossSpeed,
		enimy_roadbossCooldown: global.enimy_roadbossCooldown,
		enemy_boss_lary_DMG:    global.enemy_boss_lary_DMG,
		enemy_boss_lary_HP:     global.enemy_boss_lary_HP,
		enemy_boss_lary_Speed:  global.enemy_boss_lary_Speed,
		enemy_boss_lary_Cooldown: global.enemy_boss_lary_Cooldown,
		bulletSpeed:           global.bulletSpeed,
		
		// Camera
		zoom_level_character:  global.zoom_level_character,
		
		// Chest & door states
		chest_states:          global.chest_states,
		door_states:           global.door_states,
		// Intro cutscene
		intro_played:          global.intro_played,
		
		// Gold coins
		gold_coins:            global.gold_coins,
		
		// Armor
		armor_level:           global.armor_level,
		owned_armors:          global.owned_armors,
		current_armor:         global.current_armor,
		player_armor:          global.player_armor,
		max_player_armor:      global.max_player_armor,
		armorPerKit:           global.armorPerKit,

		// Weapons
		owned_weapons:         global.owned_weapons,
		current_weapon:        global.current_weapon,
		weapon_ammo:           global.weapon_ammo,
		weapon_reserve_ammo:   global.weapon_reserve_ammo,
		weapon_upgrade_levels: global.weapon_upgrade_levels,
		armor_upgrade_levels:  global.armor_upgrade_levels,

		// Items (cigarettes)
		item_counts:           global.item_counts,
		speed_boost_timer:     global.speed_boost_timer,

		// Exponential pricing
		total_purchases:       global.total_purchases,
	};
	
	var _json = json_stringify(_data);
	var _filename = game_save_id + "save_slot_" + string(slot) + ".json";
	var _file = file_text_open_write(_filename);
	if (_file == -1) return false;
	
	file_text_write_string(_file, _json);
	file_text_close(_file);
	
	show_debug_message("Game saved to slot " + string(slot));
	return true;
}

/// @function scr_load_game(slot)
/// @description Loads game state from a JSON file
/// @param {real} slot The save slot number (1, 2, or 3)
/// @returns {bool} true on success, false on failure
function scr_load_game(slot) {
	if (slot < 1 || slot > 3) return false;
	
	var _filename = game_save_id + "save_slot_" + string(slot) + ".json";
	if (!file_exists(_filename)) return false;
	
	var _file = file_text_open_read(_filename);
	if (_file == -1) return false;
	
	var _json = "";
	while (!file_text_eof(_file)) {
		_json += file_text_read_string(_file);
		file_text_readln(_file);
	}
	file_text_close(_file);
	
	var _data = json_parse(_json);
	if (!is_struct(_data)) return false;
	
	// Restore player state
	global.player_hp             = _data.player_hp;
	global.max_player_hp         = _data.max_player_hp;
	if (variable_struct_exists(_data, "base_max_player_hp")) {
		global.base_max_player_hp = _data.base_max_player_hp;
	} else {
		global.base_max_player_hp = _data.max_player_hp;
	}
	global.Pos_x                 = _data.Pos_x;
	global.Pos_y                 = _data.Pos_y;
	global.latest_checkpoint     = _data.latest_checkpoint;
	global.curent_room           = _data.curent_room;
	
	// Restore player stats
	global.playerDMG             = _data.playerDMG;
	global.playerSpeed           = _data.playerSpeed;
	global.playerShootCooldown   = _data.playerShootCooldown;
	global.playerReflectCooldown = _data.playerReflectCooldown;
	global.HealValue             = _data.HealValue;
	global.HealMultiplier        = _data.HealMultiplier;
	global.HealitemCount         = _data.HealitemCount;
	global.MaxHealitemCount      = _data.MaxHealitemCount;
	global.HealCooldown          = _data.HealCooldown;
	
	// Restore difficulty
	global.difficulity           = _data.difficulity;
	
	// Restore enemy stats
	global.enemyDMG              = _data.enemyDMG;
	global.enemyHP               = _data.enemyHP;
	global.enemySpeed            = _data.enemySpeed;
	global.enemyCooldown         = _data.enemyCooldown;
	global.enimy_roadbossDMG     = _data.enimy_roadbossDMG;
	global.enimy_roadbossHP      = _data.enimy_roadbossHP;
	global.enimy_roadbossSpeed   = _data.enimy_roadbossSpeed;
	global.enimy_roadbossCooldown = _data.enimy_roadbossCooldown;
	global.enemy_boss_lary_DMG    = _data.enemy_boss_lary_DMG;
	global.enemy_boss_lary_HP     = _data.enemy_boss_lary_HP;
	global.enemy_boss_lary_Speed  = _data.enemy_boss_lary_Speed;
	global.enemy_boss_lary_Cooldown = _data.enemy_boss_lary_Cooldown;
	global.bulletSpeed           = _data.bulletSpeed;
	
	// Restore camera
	global.zoom_level_character  = _data.zoom_level_character;
	
	// Restore chest & door states
	if (variable_struct_exists(_data, "chest_states")) {
		global.chest_states = _data.chest_states;
	}
	if (variable_struct_exists(_data, "door_states")) {
		global.door_states = _data.door_states;
	}
	// Restore intro cutscene flag (backward-compatible with old saves)
	if (variable_struct_exists(_data, "intro_played")) {
		global.intro_played = _data.intro_played;
	} else {
		global.intro_played = true; // old save = intro was already seen
	}
	
	// Restore gold coins
	if (variable_struct_exists(_data, "gold_coins")) {
		global.gold_coins = _data.gold_coins;
	}
	
	// Restore armor
	if (variable_struct_exists(_data, "armor_level")) {
		global.armor_level = _data.armor_level;
	}
	if (variable_struct_exists(_data, "owned_armors")) {
		global.owned_armors = _data.owned_armors;
	} else {
		global.owned_armors = [false, false, false, false];
	}
	if (variable_struct_exists(_data, "current_armor")) {
		global.current_armor = _data.current_armor;
	} else {
		global.current_armor = -1;
	}
	if (variable_struct_exists(_data, "armor_upgrade_levels")) {
		global.armor_upgrade_levels = _data.armor_upgrade_levels;
	} else {
		global.armor_upgrade_levels = [0, 0, 0, 0];
	}
	for (var _armor_index = 0; _armor_index < array_length(global.armor_names); _armor_index++) {
		if (_armor_index >= array_length(global.armor_upgrade_levels)) global.armor_upgrade_levels[_armor_index] = 0;
		global.armor_upgrade_levels[_armor_index] = clamp(floor(global.armor_upgrade_levels[_armor_index]), 0, 4);
	}
	if (variable_struct_exists(_data, "max_player_armor")) {
		global.max_player_armor = _data.max_player_armor;
	}
	if (variable_struct_exists(_data, "armorPerKit")) {
		global.armorPerKit = _data.armorPerKit;
	}
	if (variable_struct_exists(_data, "player_armor")) {
		global.player_armor = clamp(_data.player_armor, 0, global.max_player_armor);
	}
	
	// Restore weapons
	if (variable_struct_exists(_data, "owned_weapons")) {
		global.owned_weapons = _data.owned_weapons;
	}
	if (variable_struct_exists(_data, "current_weapon")) {
		global.current_weapon = _data.current_weapon;
	}
	if (variable_struct_exists(_data, "weapon_upgrade_levels")) {
		global.weapon_upgrade_levels = _data.weapon_upgrade_levels;
	} else {
		global.weapon_upgrade_levels = [0, 0, 0, 0];
	}
	for (var _weapon_upgrade_index = 0; _weapon_upgrade_index < array_length(global.weapon_names); _weapon_upgrade_index++) {
		if (_weapon_upgrade_index >= array_length(global.weapon_upgrade_levels)) global.weapon_upgrade_levels[_weapon_upgrade_index] = 0;
		global.weapon_upgrade_levels[_weapon_upgrade_index] = clamp(floor(global.weapon_upgrade_levels[_weapon_upgrade_index]), 0, 4);
	}
	if (variable_struct_exists(_data, "weapon_ammo")) {
		global.weapon_ammo = _data.weapon_ammo;
	} else {
		global.weapon_ammo = [12, 17, 8, 30];
	}
	if (variable_struct_exists(_data, "weapon_reserve_ammo")) {
		global.weapon_reserve_ammo = _data.weapon_reserve_ammo;
	} else {
		global.weapon_reserve_ammo = [72, 102, 80, 180];
	}
	scr_sync_weapon_magazine_sizes();
	// Fill in defaults for saves created before ammunition was added.
	for (var _weapon_index = 0; _weapon_index < array_length(global.weapon_magazine_sizes); _weapon_index++) {
		if (_weapon_index >= array_length(global.weapon_ammo)) {
			global.weapon_ammo[_weapon_index] = global.weapon_magazine_sizes[_weapon_index];
		}
		if (_weapon_index >= array_length(global.weapon_reserve_ammo)) {
			global.weapon_reserve_ammo[_weapon_index] = global.weapon_starting_reserve[_weapon_index];
		}
		global.weapon_ammo[_weapon_index] = clamp(floor(global.weapon_ammo[_weapon_index]), 0, global.weapon_magazine_sizes[_weapon_index]);
		global.weapon_reserve_ammo[_weapon_index] = max(0, floor(global.weapon_reserve_ammo[_weapon_index]));
	}

	// Restore items (cigarettes)
	if (variable_struct_exists(_data, "item_counts")) {
		global.item_counts = _data.item_counts;
	} else {
		global.item_counts = [0, 0];
	}
	if (variable_struct_exists(_data, "speed_boost_timer")) {
		global.speed_boost_timer = _data.speed_boost_timer;
	} else {
		global.speed_boost_timer = 0;
	}

	// Restore exponential pricing counter
	if (variable_struct_exists(_data, "total_purchases")) {
		global.total_purchases = _data.total_purchases;
	} else {
		global.total_purchases = 0;
	}
	scr_sync_armor_level();
	
	// Set active slot
	global.active_slot = slot;
	
	// Navigate to saved room
	room_goto(global.curent_room);
	
	show_debug_message("Game loaded from slot " + string(slot));
	return true;
}

/// @function scr_delete_save(slot)
/// @description Deletes a save file
/// @param {real} slot The save slot number (1, 2, or 3)
function scr_delete_save(slot) {
	if (slot < 1 || slot > 3) return;
	
	var _filename = game_save_id + "save_slot_" + string(slot) + ".json";
	if (file_exists(_filename)) {
		file_delete(_filename);
		show_debug_message("Save slot " + string(slot) + " deleted");
	}
}

/// @function scr_save_exists(slot)
/// @description Checks if a save file exists for a given slot
/// @param {real} slot The save slot number (1, 2, or 3)
/// @returns {bool} true if save exists
function scr_save_exists(slot) {
	if (slot < 1 || slot > 3) return false;
	return file_exists(game_save_id + "save_slot_" + string(slot) + ".json");
}

/// @function scr_get_save_info(slot)
/// @description Returns a display string for a save slot
/// @param {real} slot The save slot number (1, 2, or 3)
/// @returns {string} Display info or "Empty"
function scr_get_save_info(slot) {
	if (!scr_save_exists(slot)) return "Empty";
	
	var _filename = game_save_id + "save_slot_" + string(slot) + ".json";
	var _file = file_text_open_read(_filename);
	if (_file == -1) return "Empty";
	
	var _json = "";
	while (!file_text_eof(_file)) {
		_json += file_text_read_string(_file);
		file_text_readln(_file);
	}
	file_text_close(_file);
	
	var _data = json_parse(_json);
	if (!is_struct(_data)) return "Empty";
	
	// Get difficulty name
	var _diff_name = "Normal";
	switch (_data.difficulity) {
		case 0: _diff_name = "Easy"; break;
		case 1: _diff_name = "Normal"; break;
		case 2: _diff_name = "Hard"; break;
		case 3: _diff_name = "Dominic"; break;
	}
	
	// Get room name
	var _room_name = "Unknown";
	if (_data.curent_room == Startroom_battle) { _room_name = "Start Battle"; }
	else if (_data.curent_room == Battle1)     { _room_name = "Battle 1"; }
	else if (_data.curent_room == Battle2)     { _room_name = "Battle 2"; }
	else if (_data.curent_room == bossfight)   { _room_name = "Boss Fight"; }
	else if (_data.curent_room == TestRoom)    { _room_name = "Test Room"; }
	else if (_data.curent_room == lausgang)    { _room_name = "Lausgang"; }
	else { _room_name = room_get_name(_data.curent_room); }
	
	return _diff_name + " - " + _room_name;
}

/// @function scr_sync_armor_level()
/// @description Syncs global.armor_level from global.current_armor. Call after changing equipment.
function scr_sync_armor_level() {
	if (!variable_global_exists("base_max_player_hp")) {
		global.base_max_player_hp = variable_global_exists("max_player_hp") ? global.max_player_hp : 100;
	}
	if (!variable_global_exists("max_player_hp")) global.max_player_hp = global.base_max_player_hp;

	var _armor_upgrade = 0;
	var _resistance_bonus = 0;
	global.armor_speed_bonus = 0;
	global.armor_mirror_chance = 0;
	if (global.current_armor >= 0 && global.current_armor < array_length(global.armor_resists)) {
		if (global.owned_armors[global.current_armor]) {
			if (global.current_armor < array_length(global.armor_upgrade_levels)) {
				_armor_upgrade = clamp(global.armor_upgrade_levels[global.current_armor], 0, 4);
			}
			_resistance_bonus = min(_armor_upgrade * 5, 20);
			global.armor_speed_bonus = (_armor_upgrade >= 3) ? 0.10 : 0;
			if (_armor_upgrade >= 4) global.armor_mirror_chance = 0.10;
			else if (_armor_upgrade >= 2) global.armor_mirror_chance = 0.05;
			global.armor_level = min(90, global.armor_resists[global.current_armor] + _resistance_bonus);
		} else {
			global.armor_level = 0;
		}
	} else {
		global.armor_level = 0;
	}

	var _upgrade_hp_bonus = (_armor_upgrade >= 3) ? 20 : 0;
	global.max_player_hp = global.base_max_player_hp + _upgrade_hp_bonus;
	if (variable_global_exists("player_hp")) global.player_hp = min(global.player_hp, global.max_player_hp);
}

/// @function scr_weapon_upgrade_stats(level)
/// @description Returns the cumulative combat bonuses for a weapon upgrade level.
function scr_weapon_upgrade_stats(_level) {
	_level = clamp(floor(_level), 0, 4);
	var _stats = {damage_mult:1, headshot_chance:0, poison_chance:0, magazine_bonus:0};
	if (_level >= 1) _stats.damage_mult = 1.10;
	if (_level >= 2) {
		_stats.headshot_chance = 0.05;
		_stats.magazine_bonus = 5;
	}
	if (_level >= 3) {
		_stats.damage_mult = 1.25;
		_stats.poison_chance = 0.10;
	}
	if (_level >= 4) {
		_stats.headshot_chance = 0.10;
		_stats.poison_chance = 0.15;
		_stats.magazine_bonus = 10;
	}
	return _stats;
}

/// @function scr_sync_weapon_magazine_sizes()
/// @description Rebuilds magazine capacities after loading or buying an upgrade.
function scr_sync_weapon_magazine_sizes() {
	for (var _i = 0; _i < array_length(global.weapon_base_magazine_sizes); _i++) {
		var _level = 0;
		if (_i < array_length(global.weapon_upgrade_levels)) _level = global.weapon_upgrade_levels[_i];
		var _stats = scr_weapon_upgrade_stats(_level);
		global.weapon_magazine_sizes[_i] = global.weapon_base_magazine_sizes[_i] + _stats.magazine_bonus;
	}
}

/// @function scr_weapon_bullet_hit(enemy, bullet)
/// @description Applies a weapon hit, including headshots and poison.
function scr_weapon_bullet_hit(_enemy, _bullet) {
	if (!instance_exists(_enemy) || !instance_exists(_bullet)) return;
	var _damage = global.playerDMG * _bullet.weapon_dmg_mult * _bullet.weapon_upgrade_damage_mult;
	if (random(1) < _bullet.weapon_headshot_chance) _damage *= 2;
	_enemy.hp -= _damage;

	if (random(1) < _bullet.weapon_poison_chance) {
		var _was_poisoned = variable_instance_exists(_enemy, "poison_timer") && _enemy.poison_timer > 0;
		if (!variable_instance_exists(_enemy, "poison_timer")) _enemy.poison_timer = 0;
		if (!variable_instance_exists(_enemy, "poison_tick_timer")) _enemy.poison_tick_timer = 0;
		if (!variable_instance_exists(_enemy, "poison_damage")) _enemy.poison_damage = 0;
		_enemy.poison_timer = max(_enemy.poison_timer, 3);
		_enemy.poison_damage = max(_enemy.poison_damage, _damage * 0.10);
		if (!_was_poisoned) _enemy.poison_tick_timer = 1;
		_enemy.image_blend = c_lime;
	}
}

/// @function scr_poison_enemy_step(enemy)
/// @description Ticks poison damage and clears the poisoned tint when it expires.
function scr_poison_enemy_step(_enemy) {
	if (!variable_instance_exists(_enemy, "poison_timer") || _enemy.poison_timer <= 0) return;
	var _step_seconds = delta_time / 1000000;
	_enemy.poison_timer = max(0, _enemy.poison_timer - _step_seconds);
	_enemy.poison_tick_timer -= _step_seconds;
	while (_enemy.poison_tick_timer <= 0 && _enemy.poison_timer > 0) {
		_enemy.hp -= _enemy.poison_damage;
		_enemy.poison_tick_timer += 1;
	}
	if (_enemy.poison_timer <= 0) {
		_enemy.poison_damage = 0;
		_enemy.image_blend = c_white;
	}
}

/// @function scr_mirror_enemy_bullet(player, bullet)
/// @description Has a chance to return an enemy bullet toward the nearest enemy.
function scr_mirror_enemy_bullet(_player, _bullet) {
	if (!instance_exists(_player) || !instance_exists(_bullet)) return false;
	if (!variable_global_exists("armor_mirror_chance") || global.armor_mirror_chance <= 0) return false;
	if (random(1) >= global.armor_mirror_chance) return false;

	var _target = noone;
	var _target_distance = 1000000;
	var _enemies = [enemy_lary, enemy_roadboss, enemy_boss_lary];
	for (var _i = 0; _i < array_length(_enemies); _i++) {
		var _candidate = instance_nearest(_player.x, _player.y, _enemies[_i]);
		if (instance_exists(_candidate)) {
			var _distance = point_distance(_player.x, _player.y, _candidate.x, _candidate.y);
			if (_distance < _target_distance) {
				_target = _candidate;
				_target_distance = _distance;
			}
		}
	}

	var _direction = _bullet.direction + 180;
	if (instance_exists(_target)) _direction = point_direction(_player.x, _player.y, _target.x, _target.y);
	var _reflected = instance_create_depth(_player.x, _player.y, -2, obj_player_bullet);
	_reflected.direction = _direction;
	_reflected.image_angle = _direction;
	_reflected.speed = max(global.bulletSpeed, _bullet.speed);
	_reflected.range_left = 600;
	_reflected.weapon_dmg_mult = 1;
	_reflected.weapon_upgrade_damage_mult = 1;
	_reflected.weapon_headshot_chance = 0;
	_reflected.weapon_poison_chance = 0;
	_reflected.image_blend = c_aqua;
	instance_destroy(_bullet);
	return true;
}

/// @function scr_player_near_checkpoint(player)
/// @description Uses the player's and checkpoint's collision bounds for the shared R prompt/interaction range.
function scr_player_near_checkpoint(_player) {
	if (!instance_exists(_player)) return false;
	var _checkpoints = [Checkpoint_3_Startbattleroom, Checkpoint_4_Battle1, Checkpoint_5_Battle2];
	for (var _i = 0; _i < array_length(_checkpoints); _i++) {
		var _checkpoint = instance_nearest(_player.x, _player.y, _checkpoints[_i]);
		if (instance_exists(_checkpoint)) {
			var _dx = max(0, max(_player.bbox_left - _checkpoint.bbox_right, _checkpoint.bbox_left - _player.bbox_right));
			var _dy = max(0, max(_player.bbox_top - _checkpoint.bbox_bottom, _checkpoint.bbox_top - _player.bbox_bottom));
			if (point_distance(0, 0, _dx, _dy) < 5) return true;
		}
	}
	return false;
}

/// @function scr_shop_price(base_cost)
/// @description Returns the exponential shop price for an item.
function scr_shop_price(base_cost) {
	return floor(base_cost * power(global.price_exponent, global.total_purchases));
}
