// BAZAR Shop - Step Event

var _player = new_Gamecharacter_1;
if (!instance_exists(_player)) exit;

var _dist = point_distance(x, y, _player.x, _player.y);
var _in_range = _dist < interact_range;

// --- Animation update (runs every frame) ---
if (anim_state == 1) {
	// Opening: scale/fade toward 1
	anim_scale = lerp(anim_scale, 1, anim_speed);
	anim_alpha = lerp(anim_alpha, 1, anim_speed);
	if (anim_scale > 0.99) {
		anim_scale = 1;
		anim_alpha = 1;
		anim_state = 2; // fully open
		shop_open = true;
	}
} else if (anim_state == 3) {
	// Closing: scale/fade toward 0
	anim_scale = lerp(anim_scale, 0, anim_speed);
	anim_alpha = lerp(anim_alpha, 0, anim_speed);
	if (anim_scale < 0.01) {
		anim_scale = 0;
		anim_alpha = 0;
		anim_state = 0; // fully closed
		shop_open = false;
	}
}

// --- Open / Close the shop ---
if (keyboard_check_pressed(ord("F"))) {
	if (anim_state == 0 && _in_range) {
		// Start opening
		anim_state = 1;
		anim_scale = 0;
		anim_alpha = 0;
		shop_selected = 0;
		global.can_move = false;
	} else if (anim_state == 2) {
		// Start closing
		anim_state = 3;
		global.can_move = true;
	}
}

// --- Shop is open: handle navigation, tabs, and buying/equipping ---
if (shop_open) {
	// Switch tabs with TAB
	if (keyboard_check_pressed(vk_tab)) {
		shop_tab = (shop_tab + 1) mod 2;
		shop_selected = 0;
	}
	
	// Determine item count from global arrays
	var _count = 0;
	if (shop_tab == 0) {
		_count = array_length(global.armor_names);
	} else {
		_count = array_length(global.weapon_names);
	}
	
	// Navigate up
	if (keyboard_check_pressed(vk_up)) {
		shop_selected--;
		if (shop_selected < 0) shop_selected = _count - 1;
	}
	// Navigate down
	if (keyboard_check_pressed(vk_down)) {
		shop_selected++;
		if (shop_selected >= _count) shop_selected = 0;
	}
	
	// Buy or Equip with Enter
	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
		
		// --- Armor tab ---
		if (shop_tab == 0) {
			var _owned = global.owned_armors[shop_selected];
			var _equipped = (shop_selected == global.current_armor);
			var _base_cost = global.armor_base_costs[shop_selected];
			var _price = scr_shop_price(_base_cost);
			
			if (_equipped) {
				// Already equipped - unequip
				global.current_armor = -1;
				scr_sync_armor_level();
				notif_text  = "Unequipped " + global.armor_names[shop_selected] + "!";
				notif_timer = 90;
				notif_color = make_color_rgb(180, 180, 100);
			} else if (_owned) {
				// Owned but not equipped - equip it
				global.current_armor = shop_selected;
				scr_sync_armor_level();
				notif_text  = "Equipped " + global.armor_names[shop_selected] + "!";
				notif_timer = 90;
				notif_color = make_color_rgb(100, 200, 255);
			} else {
				// Not owned - try to buy
				if (global.gold_coins < _price) {
					notif_text  = "Not enough coins! Need " + string(_price);
					notif_timer = 90;
					notif_color = make_color_rgb(220, 80, 80);
					exit;
				}
			}
				global.gold_coins -= _price;
				global.owned_armors[shop_selected] = true;
				global.current_armor = shop_selected;
				global.total_purchases++;
				scr_sync_armor_level();
				
				notif_text  = "Bought " + global.armor_names[shop_selected] + "! (" + string(_price) + " coins)";
				notif_timer = 120;
				notif_color = make_color_rgb(100, 220, 100);
			}
		}
		// --- Weapon tab ---
		else if (shop_tab == 1) {
			var _owned = global.owned_weapons[shop_selected];
			var _equipped = (shop_selected == global.current_weapon);
			var _base_cost = global.weapon_base_costs[shop_selected];
			var _price = scr_shop_price(_base_cost);
			
			if (_equipped) {
				// Already equipped
				notif_text  = "Already using " + global.weapon_names[shop_selected] + "!";
				notif_timer = 90;
				notif_color = make_color_rgb(180, 180, 100);
			} else if (_owned) {
				// Owned but not equipped - equip it
				global.current_weapon = shop_selected;
				notif_text  = "Equipped " + global.weapon_names[shop_selected] + "!";
				notif_timer = 90;
				notif_color = make_color_rgb(100, 200, 255);
			} else {
				// Not owned - try to buy
				if (global.gold_coins < _price) {
					notif_text  = "Not enough coins! Need " + string(_price);
					notif_timer = 90;
					notif_color = make_color_rgb(220, 80, 80);
					exit;
				}
				
				global.gold_coins -= _price;
				global.owned_weapons[shop_selected] = true;
				global.current_weapon = shop_selected;
				global.total_purchases++;
				
				notif_text  = "Bought " + global.weapon_names[shop_selected] + "! (" + string(_price) + " coins)";
				notif_timer = 120;
				notif_color = make_color_rgb(100, 220, 100);
			}
		}
		// --- Items tab (buy cigarettes) ---
		else {
		if (global.active_slot > 0) {
			scr_save_game(global.active_slot);
		}
	}
	
	// Close with Escape
	if (keyboard_check_pressed(vk_escape)) {
		anim_state = 3;
		global.can_move = true;
	}
}

// --- Notification timer (counts down even after shop closes) ---
if (notif_timer > 0) {
	notif_timer--;
	if (notif_timer <= 0) {
		notif_text = "";
	}
}
