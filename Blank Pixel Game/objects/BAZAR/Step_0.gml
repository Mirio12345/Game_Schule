// The bazaar keeper wanders without chasing or attacking anything.
var _movement_paused = chat_open || shop_open;
if (variable_global_exists("can_move") && !global.can_move) _movement_paused = true;

if (_movement_paused) {
	speed = 0;
} else if (wander_pause_timer > 0) {
	wander_pause_timer--;
	speed = 0;
} else if (point_distance(x, y, wander_target_x, wander_target_y) <= 12) {
	speed = 0;
	wander_pause_timer = irandom_range(45, 120);
	wander_stuck_timer = 0;
	wander_target_x = irandom_range(wander_margin, max(wander_margin, room_width - wander_margin));
	wander_target_y = irandom_range(wander_margin, max(wander_margin, room_height - wander_margin));
} else {
	var _old_x = x;
	var _old_y = y;
	var _reached_target = mp_potential_step(wander_target_x, wander_target_y, wander_speed, false);
	if (_reached_target || point_distance(x, y, wander_target_x, wander_target_y) <= 12) {
		speed = 0;
		wander_pause_timer = irandom_range(45, 120);
		wander_stuck_timer = 0;
		wander_target_x = irandom_range(wander_margin, max(wander_margin, room_width - wander_margin));
		wander_target_y = irandom_range(wander_margin, max(wander_margin, room_height - wander_margin));
	} else if (point_distance(_old_x, _old_y, x, y) < 0.1) {
		wander_stuck_timer++;
		speed = 0;
		if (wander_stuck_timer >= 30) {
			wander_pause_timer = 20;
			wander_stuck_timer = 0;
			wander_target_x = irandom_range(wander_margin, max(wander_margin, room_width - wander_margin));
			wander_target_y = irandom_range(wander_margin, max(wander_margin, room_height - wander_margin));
		}
	} else if (wander_target_x < x) {
		wander_stuck_timer = 0;
		image_xscale = -abs(image_xscale);
	} else {
		wander_stuck_timer = 0;
		image_xscale = abs(image_xscale);
	}
}

// The keeper only starts a conversation when F is pressed nearby.
var _player = instance_find(new_Gamecharacter_1, 0);
if (_player == noone) exit;

var _in_range = point_distance(x, y, _player.x, _player.y) <= interact_range;
var _click_pressed = mouse_check_button_pressed(mb_left);
var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);
var _interact_pressed = _click_pressed
	|| keyboard_check_pressed(ord("F"))
	|| keyboard_check_pressed(vk_space)
	|| keyboard_check_pressed(vk_enter);

shop_anim_time += 0.08;
shop_select_pulse = max(0, shop_select_pulse - 0.08);
// Let the most recent input device control focus, so a parked cursor does not override keyboard navigation.
if (_click_pressed) {
	shop_input_mode = "mouse";
} else if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)
|| keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)
|| keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
|| keyboard_check_pressed(ord("F"))) {
	shop_input_mode = "keyboard";
} else if (abs(_mouse_gui_x - shop_last_mouse_x) > 1 || abs(_mouse_gui_y - shop_last_mouse_y) > 1) {
	shop_input_mode = "mouse";
}
shop_last_mouse_x = _mouse_gui_x;
shop_last_mouse_y = _mouse_gui_y;

chat_alpha = lerp(chat_alpha, chat_target_alpha, 0.12);

if (shop_message_timer > 0) {
	shop_message_timer--;
	if (shop_message_timer <= 0) shop_message = "";
}

if (chat_open && !typewriter_done) {
	typewriter_pos += typewriter_speed;
	var _line_length = string_length(chat_lines[chat_page]);
	if (typewriter_pos >= _line_length) {
		typewriter_pos = _line_length;
		typewriter_done = true;
	}
}

if (chat_open) {
	if (keyboard_check_pressed(vk_escape)) {
		chat_open = false;
		chat_target_alpha = 0;
		chat_page = 0;
		global.can_move = true;
	} else if (_interact_pressed) {
		if (!typewriter_done) {
			typewriter_pos = string_length(chat_lines[chat_page]);
			typewriter_done = true;
		} else {
			chat_page++;
			if (chat_page >= chat_total) {
				chat_open = false;
				chat_target_alpha = 0;
				chat_page = 0;
				shop_open = true;
				shop_screen = 1;
				shop_selected = 0;
			} else {
				typewriter_pos = 0;
				typewriter_done = false;
			}
		}
	}
} else if (shop_open) {
	var _selection_before = shop_selected;
	var _close_pressed = keyboard_check_pressed(vk_escape);
	var _up_pressed = keyboard_check_pressed(vk_up);
	var _down_pressed = keyboard_check_pressed(vk_down);
	var _left_pressed = keyboard_check_pressed(vk_left);
	var _right_pressed = keyboard_check_pressed(vk_right);
	var _confirm_pressed = keyboard_check_pressed(vk_enter)
		|| keyboard_check_pressed(vk_space)
		|| keyboard_check_pressed(ord("F"));

	if (shop_screen == 1) {
		var _gui_w = display_get_gui_width();
		var _gui_h = display_get_gui_height();
		var _box_w = _gui_w * 0.7;
		var _box_h = 148;
		var _box_x = (_gui_w - _box_w) * 0.5;
		var _box_y = _gui_h - _box_h - 20;
		var _choice_gap = 10;
		var _choice_w = (_box_w - 32 - _choice_gap * 2) / 3;
		var _choice_h = 40;
		var _choice_y = _box_y + 62;
		var _clicked_choice = -1;
		var _hover_choice = -1;

		if (_mouse_gui_y >= _choice_y && _mouse_gui_y <= _choice_y + _choice_h) {
			for (var _choice_index = 0; _choice_index < 3; _choice_index++) {
				var _choice_x = _box_x + 16 + _choice_index * (_choice_w + _choice_gap);
				if (_mouse_gui_x >= _choice_x && _mouse_gui_x <= _choice_x + _choice_w) {
					_hover_choice = _choice_index;
					break;
				}
			}
		}
		if (_click_pressed) _clicked_choice = _hover_choice;

		if (_close_pressed) {
			shop_open = false;
			shop_screen = 0;
			global.can_move = true;
		} else {
			if (_up_pressed || _left_pressed) shop_selected = (shop_selected + 2) mod 3;
			if (_down_pressed || _right_pressed) shop_selected = (shop_selected + 1) mod 3;
			if (shop_input_mode == "mouse" && _hover_choice >= 0) shop_selected = _hover_choice;
			if (_clicked_choice >= 0) shop_selected = _clicked_choice;

			if (_clicked_choice >= 0 || _confirm_pressed) {
				if (shop_selected == 0) shop_screen = 2;
				else if (shop_selected == 1) shop_screen = 3;
				else shop_screen = 4;
				shop_selected = 0;
				shop_message = "";
			}
		}
	} else if (shop_screen == 2) {
		if (_close_pressed) {
			shop_screen = 1;
			shop_selected = 0;
			shop_message = "";
		} else {
			var _weapon_count = array_length(global.weapon_names);
			var _weapon_option_count = _weapon_count + 1;
			if (_up_pressed) shop_selected = (shop_selected + _weapon_option_count - 1) mod _weapon_option_count;
			if (_down_pressed) shop_selected = (shop_selected + 1) mod _weapon_option_count;

			var _panel_x = display_get_gui_width() * 0.12;
			var _panel_w = display_get_gui_width() * 0.76;
			var _rows_top = display_get_gui_height() * 0.31;
			var _row_h = 62;
			var _row_gap = 7;
			var _clicked_row = -1;
			var _clicked_action = false;
			var _hover_row = -1;
			for (var i = 0; i < _weapon_option_count; i++) {
				var _row_y = _rows_top + i * (_row_h + _row_gap);
				if (_mouse_gui_x >= _panel_x + 18 && _mouse_gui_x <= _panel_x + _panel_w - 18
				&& _mouse_gui_y >= _row_y && _mouse_gui_y <= _row_y + _row_h) {
					_hover_row = i;
					if (_click_pressed) {
						_clicked_row = i;
						_clicked_action = _mouse_gui_x >= _panel_x + _panel_w - 168;
					}
					break;
				}
			}
			if (shop_input_mode == "mouse" && _hover_row >= 0) shop_selected = _hover_row;
			if (_clicked_row >= 0) shop_selected = _clicked_row;

			if (_confirm_pressed || (_clicked_row >= 0 && _clicked_action)) {
				var _weapon_changed = false;
				if (shop_selected == _weapon_count) {
					var _ammo_weapon_index = clamp(global.current_weapon, 0, _weapon_count - 1);
					var _ammo_pack = global.weapon_magazine_sizes[_ammo_weapon_index] * 2;
					var _ammo_price = scr_shop_price(ammo_pack_base_cost);
					if (!global.owned_weapons[_ammo_weapon_index]) {
						shop_message = "Buy a weapon before purchasing its ammo.";
						shop_message_color = make_color_rgb(210, 190, 110);
					} else if (global.gold_coins < _ammo_price) {
						shop_message = "Not enough coins. Need " + string(_ammo_price) + ".";
						shop_message_color = make_color_rgb(230, 100, 100);
					} else {
						global.gold_coins -= _ammo_price;
						global.weapon_reserve_ammo[_ammo_weapon_index] += _ammo_pack;
						global.total_purchases++;
						shop_message = "Bought " + string(_ammo_pack) + " rounds for " + global.weapon_names[_ammo_weapon_index] + ".";
						shop_message_color = make_color_rgb(100, 220, 100);
						_weapon_changed = true;
					}
				} else {
					var _weapon_index = shop_selected;
					var _weapon_owned = global.owned_weapons[_weapon_index];
					if (_weapon_owned) {
						if (global.current_weapon == _weapon_index) {
							shop_message = "You are already using " + global.weapon_names[_weapon_index] + ".";
							shop_message_color = make_color_rgb(210, 190, 110);
						} else {
							global.current_weapon = _weapon_index;
							shop_message = "Equipped " + global.weapon_names[_weapon_index] + ".";
							shop_message_color = make_color_rgb(100, 200, 255);
							_weapon_changed = true;
						}
					} else {
						var _weapon_price = scr_shop_price(global.weapon_base_costs[_weapon_index]);
						if (global.gold_coins < _weapon_price) {
							shop_message = "Not enough coins. Need " + string(_weapon_price) + ".";
							shop_message_color = make_color_rgb(230, 100, 100);
						} else {
							global.gold_coins -= _weapon_price;
							global.owned_weapons[_weapon_index] = true;
							global.current_weapon = _weapon_index;
							global.weapon_ammo[_weapon_index] = global.weapon_magazine_sizes[_weapon_index];
							global.weapon_reserve_ammo[_weapon_index] = global.weapon_starting_reserve[_weapon_index];
							global.total_purchases++;
							shop_message = "Bought and equipped " + global.weapon_names[_weapon_index] + "!";
							shop_message_color = make_color_rgb(100, 220, 100);
							_weapon_changed = true;
						}
					}
				}
				shop_message_timer = 150;
				if (_weapon_changed && global.active_slot > 0) scr_save_game(global.active_slot);
			}
		}
	} else if (shop_screen == 3) {
		if (_close_pressed) {
			shop_screen = 1;
			shop_selected = 1;
			shop_message = "";
		} else {
			var _armor_count = array_length(global.armor_names);
			var _option_count = _armor_count + 1;
			if (_up_pressed) shop_selected = (shop_selected + _option_count - 1) mod _option_count;
			if (_down_pressed) shop_selected = (shop_selected + 1) mod _option_count;

			var _panel_x = display_get_gui_width() * 0.12;
			var _panel_w = display_get_gui_width() * 0.76;
			var _rows_top = display_get_gui_height() * 0.32;
			var _row_h = 68;
			var _row_gap = 9;
			var _clicked_row = -1;
			var _clicked_action = false;
			var _hover_row = -1;
			for (var i = 0; i < _option_count; i++) {
				var _row_y = _rows_top + i * (_row_h + _row_gap);
				if (_mouse_gui_x >= _panel_x + 18 && _mouse_gui_x <= _panel_x + _panel_w - 18
				&& _mouse_gui_y >= _row_y && _mouse_gui_y <= _row_y + _row_h) {
					_hover_row = i;
					if (_click_pressed) {
						_clicked_row = i;
						_clicked_action = _mouse_gui_x >= _panel_x + _panel_w - 168;
					}
					break;
				}
			}
			if (shop_input_mode == "mouse" && _hover_row >= 0) shop_selected = _hover_row;
			if (_clicked_row >= 0) shop_selected = _clicked_row;

			if (_confirm_pressed || (_clicked_row >= 0 && _clicked_action)) {
				if (shop_selected == _armor_count) {
					var _kit_price = scr_shop_price(armor_kit_base_cost);
					if (global.player_armor >= global.max_player_armor) {
						shop_message = "Your armor is already full.";
						shop_message_color = make_color_rgb(210, 190, 110);
					} else if (global.gold_coins < _kit_price) {
						shop_message = "Not enough coins. Need " + string(_kit_price) + ".";
						shop_message_color = make_color_rgb(230, 100, 100);
					} else {
						global.gold_coins -= _kit_price;
						global.player_armor = min(global.player_armor + global.armorPerKit, global.max_player_armor);
						global.total_purchases++;
						shop_message = "Armor repaired to " + string(global.player_armor)
							+ " / " + string(global.max_player_armor) + ".";
						shop_message_color = make_color_rgb(100, 220, 100);
						if (global.active_slot > 0) scr_save_game(global.active_slot);
					}
				} else {
					var _armor_index = shop_selected;
					var _armor_changed = false;
					if (global.owned_armors[_armor_index]) {
						if (global.current_armor == _armor_index) {
							shop_message = "You are already wearing " + global.armor_names[_armor_index] + ".";
							shop_message_color = make_color_rgb(210, 190, 110);
						} else {
							global.current_armor = _armor_index;
							scr_sync_armor_level();
							shop_message = "Equipped " + global.armor_names[_armor_index] + ".";
							shop_message_color = make_color_rgb(100, 200, 255);
							_armor_changed = true;
						}
					} else {
						var _armor_price = scr_shop_price(global.armor_base_costs[_armor_index]);
						if (global.gold_coins < _armor_price) {
							shop_message = "Not enough coins. Need " + string(_armor_price) + ".";
							shop_message_color = make_color_rgb(230, 100, 100);
						} else {
							global.gold_coins -= _armor_price;
							global.owned_armors[_armor_index] = true;
							global.current_armor = _armor_index;
							global.total_purchases++;
							scr_sync_armor_level();
							shop_message = "Bought and equipped " + global.armor_names[_armor_index] + "!";
							shop_message_color = make_color_rgb(100, 220, 100);
							_armor_changed = true;
						}
					}
					if (_armor_changed && global.active_slot > 0) scr_save_game(global.active_slot);
				}
				shop_message_timer = 150;
		}
		}
	} else if (shop_screen == 4) {
		if (_close_pressed) {
			shop_screen = 1;
			shop_selected = 2;
			shop_message = "";
		} else {
			if (_up_pressed) shop_selected = (shop_selected + 1) mod 2;
			if (_down_pressed) shop_selected = (shop_selected + 1) mod 2;

			var _panel_x = display_get_gui_width() * 0.12;
			var _panel_w = display_get_gui_width() * 0.76;
			var _rows_top = display_get_gui_height() * 0.32;
			var _row_h = 112;
			var _row_gap = 16;
			var _clicked_row = -1;
			var _clicked_action = false;
			var _hover_row = -1;
			for (var _upgrade_row = 0; _upgrade_row < 2; _upgrade_row++) {
				var _row_y = _rows_top + _upgrade_row * (_row_h + _row_gap);
				if (_mouse_gui_x >= _panel_x + 18 && _mouse_gui_x <= _panel_x + _panel_w - 18
				&& _mouse_gui_y >= _row_y && _mouse_gui_y <= _row_y + _row_h) {
					_hover_row = _upgrade_row;
					if (_click_pressed) {
						_clicked_row = _upgrade_row;
						_clicked_action = _mouse_gui_x >= _panel_x + _panel_w - 168;
					}
					break;
				}
			}
			if (shop_input_mode == "mouse" && _hover_row >= 0) shop_selected = _hover_row;
			if (_clicked_row >= 0) shop_selected = _clicked_row;

			if (_confirm_pressed || (_clicked_row >= 0 && _clicked_action)) {
				var _upgrade_changed = false;
				if (shop_selected == 0) {
					var _weapon_index = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
					var _weapon_level = global.weapon_upgrade_levels[_weapon_index];
					if (_weapon_level >= 4) {
						shop_message = "This weapon is already at Level 4.";
						shop_message_color = make_color_rgb(210, 190, 110);
					} else {
					var _weapon_upgrade_price = scr_shop_price(global.weapon_upgrade_costs[_weapon_level]);
					if (global.gold_coins < _weapon_upgrade_price) {
						shop_message = "Not enough coins. Need " + string(_weapon_upgrade_price) + ".";
						shop_message_color = make_color_rgb(230, 100, 100);
					} else {
						var _old_capacity = global.weapon_magazine_sizes[_weapon_index];
						global.gold_coins -= _weapon_upgrade_price;
						global.weapon_upgrade_levels[_weapon_index]++;
						scr_sync_weapon_magazine_sizes();
						var _added_rounds = global.weapon_magazine_sizes[_weapon_index] - _old_capacity;
						global.weapon_ammo[_weapon_index] = min(global.weapon_magazine_sizes[_weapon_index], global.weapon_ammo[_weapon_index] + _added_rounds);
						global.total_purchases++;
						shop_message = global.weapon_names[_weapon_index] + " upgraded to Level " + string(global.weapon_upgrade_levels[_weapon_index]) + ".";
						shop_message_color = make_color_rgb(100, 220, 100);
						_upgrade_changed = true;
					}
					}
				} else {
					var _armor_index = global.current_armor;
					if (_armor_index < 0 || _armor_index >= array_length(global.armor_names) || !global.owned_armors[_armor_index]) {
						shop_message = "Buy and equip armor before upgrading it.";
						shop_message_color = make_color_rgb(210, 190, 110);
					} else {
						var _armor_level = global.armor_upgrade_levels[_armor_index];
						if (_armor_level >= 4) {
							shop_message = "This armor is already at Level 4.";
							shop_message_color = make_color_rgb(210, 190, 110);
						} else {
						var _armor_upgrade_price = scr_shop_price(global.armor_upgrade_costs[_armor_level]);
						if (global.gold_coins < _armor_upgrade_price) {
							shop_message = "Not enough coins. Need " + string(_armor_upgrade_price) + ".";
							shop_message_color = make_color_rgb(230, 100, 100);
						} else {
							global.gold_coins -= _armor_upgrade_price;
							global.armor_upgrade_levels[_armor_index]++;
							scr_sync_armor_level();
							if (global.armor_upgrade_levels[_armor_index] == 3) {
								global.player_hp = min(global.max_player_hp, global.player_hp + 20);
							}
							global.total_purchases++;
							shop_message = global.armor_names[_armor_index] + " upgraded to Level " + string(global.armor_upgrade_levels[_armor_index]) + ".";
							shop_message_color = make_color_rgb(100, 220, 100);
							_upgrade_changed = true;
						}
						}
					}
				}
				shop_message_timer = 150;
				if (_upgrade_changed && global.active_slot > 0) scr_save_game(global.active_slot);
			}
		}
	}
	if (shop_selected != _selection_before) shop_select_pulse = 1;
} else {
	var _can_interact = !variable_global_exists("can_move") || global.can_move;
	var _talk_pressed = keyboard_check_pressed(ord("F"));

	if (_can_interact && _in_range && _talk_pressed) {
		chat_open = true;
		chat_page = 0;
		chat_target_alpha = 1;
		typewriter_pos = 0;
		typewriter_done = false;
		global.can_move = false;
	}
}
