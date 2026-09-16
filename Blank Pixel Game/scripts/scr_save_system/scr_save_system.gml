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
