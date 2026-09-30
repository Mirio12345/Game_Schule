// Cyberpunk dialogue and shop interface.
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _choice_screen = shop_open && shop_screen == 1;
var _draw_chat_box = _choice_screen || (!shop_open && chat_alpha > 0.01);
var _navy = make_color_rgb(8, 11, 25);
var _panel = make_color_rgb(13, 17, 36);
var _row = make_color_rgb(20, 25, 48);
var _cyan = make_color_rgb(45, 235, 255);
var _magenta = make_color_rgb(255, 55, 190);
var _muted = make_color_rgb(145, 165, 190);
var _pulse_wave = 0.5 + 0.5 * sin(shop_anim_time * 6);
var _dialog_box_h = 136;
var _dialog_bubble_h = 46;

if (_draw_chat_box && !_choice_screen) {
	draw_set_font(-1);
	var _dialog_box_w = _gui_w * 0.8;
	var _dialog_bubble_w = _dialog_box_w * 0.82;
	var _dialog_text_w = _dialog_bubble_w - 24;
	var _dialog_text_h = string_height_ext(chat_lines[chat_page], 18, _dialog_text_w);
	_dialog_bubble_h = max(46, _dialog_text_h + 14);
	_dialog_box_h = max(136, _dialog_bubble_h + 88);
}

if (_draw_chat_box) {
	var _box_w = _gui_w * (_choice_screen ? 0.7 : 0.8);
	var _box_h = _choice_screen ? 148 : _dialog_box_h;
	var _box_x = (_gui_w - _box_w) * 0.5;
	var _box_y = _gui_h - _box_h - 20;
	var _box_alpha = _choice_screen ? 1 : chat_alpha;

	draw_set_alpha(_box_alpha);
	draw_set_color(_navy);
	draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
	draw_set_color(_cyan);
	draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);
	draw_set_color(_magenta);
	draw_line(_box_x + 12, _box_y + 3, _box_x + 74, _box_y + 3);
	draw_set_color(make_color_rgb(31, 55, 78));
	draw_line(_box_x + 14, _box_y + 31, _box_x + _box_w - 14, _box_y + 31);

	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(_cyan);
	draw_text(_box_x + 16, _box_y + 10, "BAZARMEN // MARKET ACCESS");

	if (_choice_screen) {
		draw_set_color(c_white);
		draw_text(_box_x + 16, _box_y + 39, "What do you need for the road ahead?");
		draw_set_halign(fa_right);
		draw_set_color(_magenta);
		draw_text(_box_x + _box_w - 16, _box_y + 10, string(global.gold_coins) + " CREDITS");

		var _choice_gap = 10;
		var _choice_w = (_box_w - 32 - _choice_gap * 2) / 3;
		var _choice_h = 40;
		var _choice_y = _box_y + 62;
	for (var c = 0; c < 3; c++) {
			var _button_x = _box_x + 16 + c * (_choice_w + _choice_gap);
			var _accent = (c == 0) ? _cyan : _magenta;
			var _selected = (c == shop_selected);
			draw_set_alpha(1);
			draw_set_color(_selected ? make_color_rgb(18, 45, 62) : make_color_rgb(17, 22, 42));
			draw_rectangle(_button_x, _choice_y, _button_x + _choice_w, _choice_y + _choice_h, false);
			if (_selected) {
				var _expand = shop_select_pulse * 2 + 0.5 + _pulse_wave;
				draw_set_alpha(0.22 + 0.22 * _pulse_wave);
				draw_set_color(_accent);
				draw_rectangle(_button_x - _expand, _choice_y - _expand, _button_x + _choice_w + _expand, _choice_y + _choice_h + _expand, true);
				draw_set_alpha(1);
			}
			draw_set_color(_selected ? _accent : make_color_rgb(67, 91, 117));
			draw_rectangle(_button_x, _choice_y, _button_x + _choice_w, _choice_y + _choice_h, true);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			if (c == 0) draw_text(_button_x + _choice_w * 0.5, _choice_y + _choice_h * 0.5, "01  //  WEAPONS");
			else if (c == 1) draw_text(_button_x + _choice_w * 0.5, _choice_y + _choice_h * 0.5, "02  //  ARMOR");
			else draw_text(_button_x + _choice_w * 0.5, _choice_y + _choice_h * 0.5, "03  //  UPGRADES");
		}

		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);
		draw_set_color(_muted);
		draw_text(_box_x + _box_w - 16, _box_y + _box_h - 7, "LEFT / RIGHT: Choose    ENTER / Click: Select    ESC: Leave");
	} else {
		var _speaker = chat_speakers[chat_page];
		var _player_speaking = (_speaker == "PLAYER");
		var _speaker_color = _player_speaking ? _magenta : _cyan;
		var _bubble_w = _box_w * 0.82;
		var _bubble_h = _dialog_bubble_h;
		var _bubble_x = _player_speaking ? _box_x + _box_w - _bubble_w - 16 : _box_x + 16;
		var _bubble_y = _box_y + 56;
		var _visible_length = min(typewriter_pos, string_length(chat_lines[chat_page]));
		var _visible_text = string_copy(chat_lines[chat_page], 1, _visible_length);
		draw_set_color(_player_speaking ? make_color_rgb(34, 19, 45) : make_color_rgb(13, 34, 47));
		draw_rectangle(_bubble_x, _bubble_y, _bubble_x + _bubble_w, _bubble_y + _bubble_h, false);
		draw_set_color(_speaker_color);
		draw_rectangle(_bubble_x, _bubble_y, _bubble_x + _bubble_w, _bubble_y + _bubble_h, true);

		draw_set_valign(fa_top);
		draw_set_color(_speaker_color);
		if (_player_speaking) {
			draw_set_halign(fa_right);
			draw_text(_bubble_x + _bubble_w, _box_y + 38, "PLAYER");
			draw_set_halign(fa_right);
			draw_set_color(make_color_rgb(235, 238, 248));
			draw_text_ext(_bubble_x + _bubble_w - 12, _bubble_y + 7, _visible_text, 18, _bubble_w - 24);
		} else {
			draw_set_halign(fa_left);
			draw_text(_bubble_x, _box_y + 38, "BAZARMEN");
			draw_set_halign(fa_left);
			draw_set_color(make_color_rgb(235, 238, 248));
			draw_text_ext(_bubble_x + 12, _bubble_y + 7, _visible_text, 18, _bubble_w - 24);
		}

		if (typewriter_done) {
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_set_color(_muted);
			draw_text(_box_x + _box_w - 16, _box_y + _box_h - 8, "[Click / F] Continue   [Esc] Close");
		}
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_color(c_white);
}

// Main inventory screens.
if (shop_open && shop_screen > 1) {
	var _panel_w = _gui_w * 0.76;
	var _panel_h = _gui_h * 0.78;
	var _panel_x = (_gui_w - _panel_w) * 0.5;
	var _panel_y = (_gui_h - _panel_h) * 0.5;

	draw_set_alpha(0.78);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gui_w, _gui_h, false);
	draw_set_alpha(1);

	draw_set_color(_magenta);
	draw_rectangle(_panel_x - 3, _panel_y - 3, _panel_x + _panel_w + 3, _panel_y + _panel_h + 3, true);
	draw_set_color(_panel);
	draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);
	draw_set_color(_cyan);
	draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);
	draw_set_color(_cyan);
	draw_line(_panel_x + 18, _panel_y + 6, _panel_x + 104, _panel_y + 6);
	draw_set_color(_magenta);
	draw_line(_panel_x + _panel_w - 104, _panel_y + _panel_h - 6, _panel_x + _panel_w - 18, _panel_y + _panel_h - 6);

	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(_muted);
	draw_text(_panel_x + 20, _panel_y + 8, "NIGHT MARKET  /  TERMINAL 07");
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(_cyan);

	if (shop_screen == 2) {
		draw_text(_gui_w * 0.5, _panel_y + 22, "WEAPON SYSTEMS");
		draw_set_halign(fa_right);
		draw_set_color(_magenta);
		draw_text(_panel_x + _panel_w - 20, _panel_y + 22, string(global.gold_coins) + " CREDITS");

		draw_set_halign(fa_left);
		draw_set_color(_muted);
		draw_text(_panel_x + 24, _panel_y + 62, "Equipped: " + global.weapon_names[global.current_weapon]);

		var _weapon_count = array_length(global.weapon_names);
		var _weapon_option_count = _weapon_count + 1;
		var _rows_top = _gui_h * 0.31;
		var _row_h = 62;
		var _row_gap = 7;
		for (var i = 0; i < _weapon_option_count; i++) {
			var _row_y = _rows_top + i * (_row_h + _row_gap);
			var _selected = (i == shop_selected);
			var _row_left = _panel_x + 18;
			var _row_right = _panel_x + _panel_w - 18;
			draw_set_color(_selected ? make_color_rgb(17, 43, 58) : _row);
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, false);
			if (_selected) {
				var _expand = shop_select_pulse * 2 + 0.5 + _pulse_wave;
				draw_set_alpha(0.2 + 0.2 * _pulse_wave);
				draw_set_color(_cyan);
				draw_rectangle(_row_left - _expand, _row_y - _expand, _row_right + _expand, _row_y + _row_h + _expand, true);
				draw_set_alpha(1);
			}
			draw_set_color(_selected ? _cyan : make_color_rgb(59, 75, 103));
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, true);
			draw_set_color(_selected ? _cyan : make_color_rgb(55, 72, 94));
			draw_rectangle(_row_left + 1, _row_y + 1, _row_left + 4, _row_y + _row_h - 1, false);

			var _row_title = "";
			var _row_desc = "";
			var _action_text = "";
			var _action_color = make_color_rgb(23, 105, 112);
			if (i < _weapon_count) {
				_row_title = global.weapon_names[i];
				var _damage_bonus = round((global.weapon_dmg_mults[i] - 1) * 100);
				var _fire_bonus = round((1 - global.weapon_spd_mults[i]) * 100);
				_row_desc = "Standard sidearm";
				if (_damage_bonus > 0 || _fire_bonus > 0) {
					_row_desc = "";
					if (_damage_bonus > 0) _row_desc += "+" + string(_damage_bonus) + "% damage";
					if (_fire_bonus > 0) {
						if (_row_desc != "") _row_desc += ", ";
						_row_desc += "+" + string(_fire_bonus) + "% fire rate";
					}
				}
				if (global.owned_weapons[i]) {
					if (global.current_weapon == i) {
						_action_text = "USING";
						_action_color = make_color_rgb(90, 40, 105);
					} else {
						_action_text = "EQUIP";
						_action_color = make_color_rgb(23, 72, 112);
					}
				} else {
					_action_text = string(scr_shop_price(global.weapon_base_costs[i])) + " CREDITS";
				}
			} else {
				var _ammo_weapon_index = clamp(global.current_weapon, 0, _weapon_count - 1);
				var _ammo_pack = global.weapon_magazine_sizes[_ammo_weapon_index] * 2;
				_row_title = "AMMO PACK  //  " + global.weapon_names[_ammo_weapon_index];
				_row_desc = "Adds " + string(_ammo_pack) + " rounds to reserve (current: " + string(global.weapon_reserve_ammo[_ammo_weapon_index]) + ").";
				_action_text = string(scr_shop_price(ammo_pack_base_cost)) + " CREDITS";
			}

			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_color(_selected ? _cyan : c_white);
			draw_text(_panel_x + 32, _row_y + 8, _row_title);
			draw_set_color(_muted);
			draw_text(_panel_x + 32, _row_y + 36, _row_desc);
			var _preview_weapon_index = (i < _weapon_count) ? i : clamp(global.current_weapon, 0, _weapon_count - 1);
			draw_sprite_ext(global.weapon_sprites[_preview_weapon_index], 0, _row_right - 224, _row_y + _row_h * 0.5, global.weapon_shop_sprite_scales[_preview_weapon_index], global.weapon_shop_sprite_scales[_preview_weapon_index], 0, c_white, 1);

			draw_set_color(_action_color);
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 10, _panel_x + _panel_w - 28, _row_y + 58, false);
			draw_set_color(_selected ? _magenta : make_color_rgb(85, 76, 122));
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 10, _panel_x + _panel_w - 28, _row_y + 58, true);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_text(_panel_x + _panel_w - 98, _row_y + 34, _action_text);
		}

		if (shop_message_timer > 0) {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(shop_message_color);
			draw_text(_gui_w * 0.5, _gui_h * 0.77, shop_message);
		}
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_color(_muted);
		draw_text(_gui_w * 0.5, _panel_y + _panel_h - 18, "UP / DOWN: Select    ENTER or action button: Buy / Equip / Ammo    ESC: Back");
	} else if (shop_screen == 3) {
		draw_text(_gui_w * 0.5, _panel_y + 22, "ARMOR SYSTEMS");
		draw_set_halign(fa_right);
		draw_set_color(_magenta);
		draw_text(_panel_x + _panel_w - 20, _panel_y + 22, string(global.gold_coins) + " CREDITS");

		var _equipped_armor = "None";
		if (global.current_armor >= 0 && global.current_armor < array_length(global.armor_names)) {
			_equipped_armor = global.armor_names[global.current_armor];
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(_muted);
		draw_text(_panel_x + 24, _panel_y + 62, "Equipped: " + _equipped_armor + "  (" + string(global.armor_level) + "% resistance)");

		var _armor_count = array_length(global.armor_names);
		var _option_count = _armor_count + 1;
		var _rows_top = _gui_h * 0.32;
		var _row_h = 68;
		var _row_gap = 9;
		for (var i = 0; i < _option_count; i++) {
			var _row_y = _rows_top + i * (_row_h + _row_gap);
			var _selected = (i == shop_selected);
			var _row_left = _panel_x + 18;
			var _row_right = _panel_x + _panel_w - 18;
			draw_set_color(_selected ? make_color_rgb(17, 43, 58) : _row);
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, false);
			if (_selected) {
				var _expand = shop_select_pulse * 2 + 0.5 + _pulse_wave;
				draw_set_alpha(0.2 + 0.2 * _pulse_wave);
				draw_set_color(_cyan);
				draw_rectangle(_row_left - _expand, _row_y - _expand, _row_right + _expand, _row_y + _row_h + _expand, true);
				draw_set_alpha(1);
			}
			draw_set_color(_selected ? _cyan : make_color_rgb(59, 75, 103));
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, true);
			draw_set_color(_selected ? _magenta : make_color_rgb(55, 72, 94));
			draw_rectangle(_row_left + 1, _row_y + 1, _row_left + 4, _row_y + _row_h - 1, false);

			var _is_kit = (i == _armor_count);
			var _armor_name = "Armor Repair Kit";
			if (!_is_kit) _armor_name = global.armor_names[i];
			var _armor_desc = "";
			var _action_text = "";
			var _action_color = make_color_rgb(23, 105, 112);
			if (_is_kit) {
				_armor_desc = "Restores " + string(global.armorPerKit) + " armor (" + string(global.player_armor)
					+ " / " + string(global.max_player_armor) + ").";
				if (global.player_armor >= global.max_player_armor) {
					_action_text = "FULL";
					_action_color = make_color_rgb(45, 51, 68);
				} else {
					_action_text = string(scr_shop_price(armor_kit_base_cost)) + " CREDITS";
				}
			} else {
				_armor_desc = string(global.armor_resists[i]) + "% damage resistance";
				if (global.owned_armors[i]) {
					if (global.current_armor == i) {
						_action_text = "WEARING";
						_action_color = make_color_rgb(90, 40, 105);
					} else {
						_action_text = "EQUIP";
						_action_color = make_color_rgb(23, 72, 112);
					}
				} else {
					_action_text = string(scr_shop_price(global.armor_base_costs[i])) + " CREDITS";
				}
			}

			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_color(_selected ? _cyan : c_white);
			draw_text(_panel_x + 32, _row_y + 8, _armor_name);
			draw_set_color(_muted);
			draw_text(_panel_x + 32, _row_y + 36, _armor_desc);

			draw_set_color(_action_color);
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 10, _panel_x + _panel_w - 28, _row_y + 58, false);
			draw_set_color(_selected ? _magenta : make_color_rgb(85, 76, 122));
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 10, _panel_x + _panel_w - 28, _row_y + 58, true);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_text(_panel_x + _panel_w - 98, _row_y + 34, _action_text);
		}

		if (shop_message_timer > 0) {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(shop_message_color);
			draw_text(_gui_w * 0.5, _gui_h * 0.275, shop_message);
		}
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_color(_muted);
		draw_text(_gui_w * 0.5, _panel_y + _panel_h - 18, "UP / DOWN: Select    ENTER or action button: Buy / Equip    ESC: Back");
	} else if (shop_screen == 4) {
		draw_text(_gui_w * 0.5, _panel_y + 22, "UPGRADE LAB  /  LEVELS 1-4");
		draw_set_halign(fa_right);
		draw_set_color(_magenta);
		draw_text(_panel_x + _panel_w - 20, _panel_y + 22, string(global.gold_coins) + " CREDITS");
		draw_set_halign(fa_left);
		draw_set_color(_muted);
		draw_text(_panel_x + 24, _panel_y + 62, "Upgrade your equipped weapon or armor. Each item keeps its own level.");

		var _weapon_index = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
		var _armor_index = global.current_armor;
		var _rows_top = _gui_h * 0.32;
		var _row_h = 112;
		var _row_gap = 16;
		for (var _upgrade_row = 0; _upgrade_row < 2; _upgrade_row++) {
			var _row_y = _rows_top + _upgrade_row * (_row_h + _row_gap);
			var _row_left = _panel_x + 18;
			var _row_right = _panel_x + _panel_w - 18;
			var _selected = (_upgrade_row == shop_selected);
			draw_set_color(_selected ? make_color_rgb(17, 43, 58) : _row);
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, false);
			if (_selected) {
				var _expand = shop_select_pulse * 2 + 0.5 + _pulse_wave;
				draw_set_alpha(0.2 + 0.2 * _pulse_wave);
				draw_set_color(_cyan);
				draw_rectangle(_row_left - _expand, _row_y - _expand, _row_right + _expand, _row_y + _row_h + _expand, true);
				draw_set_alpha(1);
			}
			draw_set_color(_selected ? _cyan : make_color_rgb(59, 75, 103));
			draw_rectangle(_row_left, _row_y, _row_right, _row_y + _row_h, true);

			var _upgrade_level = 0;
			var _upgrade_title = "";
			var _upgrade_desc = "";
			var _upgrade_action = "";
			var _upgrade_action_color = make_color_rgb(23, 72, 112);
			if (_upgrade_row == 0) {
				_upgrade_level = global.weapon_upgrade_levels[_weapon_index];
				_upgrade_title = "WEAPON  //  " + global.weapon_names[_weapon_index];
				if (_upgrade_level > 0) {
					_upgrade_desc = "Active: Level " + string(_upgrade_level) + " - " + global.weapon_upgrade_descriptions[_upgrade_level - 1] + "\n";
				}
				if (_upgrade_level < 4) {
					_upgrade_desc += "Next: Level " + string(_upgrade_level + 1) + " - " + global.weapon_upgrade_descriptions[_upgrade_level];
					_upgrade_action = string(scr_shop_price(global.weapon_upgrade_costs[_upgrade_level])) + " CREDITS";
				} else {
					_upgrade_desc += "All weapon upgrades unlocked.";
					_upgrade_action = "MAX LEVEL";
					_upgrade_action_color = make_color_rgb(45, 51, 68);
				}
			} else {
				if (_armor_index >= 0 && _armor_index < array_length(global.armor_names) && global.owned_armors[_armor_index]) {
					_upgrade_level = global.armor_upgrade_levels[_armor_index];
					_upgrade_title = "ARMOR  //  " + global.armor_names[_armor_index];
				} else {
					_upgrade_title = "ARMOR  //  NONE EQUIPPED";
					_upgrade_desc = "Buy and equip armor to unlock its upgrades.\n";
				}
				if (_upgrade_level > 0) {
					_upgrade_desc += "Active: Level " + string(_upgrade_level) + " - " + global.armor_upgrade_descriptions[_upgrade_level - 1] + "\n";
				}
				if (_upgrade_level < 4) {
					_upgrade_desc += "Next: Level " + string(_upgrade_level + 1) + " - " + global.armor_upgrade_descriptions[_upgrade_level];
					if (_armor_index >= 0 && _armor_index < array_length(global.armor_names) && global.owned_armors[_armor_index]) {
						_upgrade_action = string(scr_shop_price(global.armor_upgrade_costs[_upgrade_level])) + " CREDITS";
					} else {
						_upgrade_action = "BUY ARMOR FIRST";
						_upgrade_action_color = make_color_rgb(45, 51, 68);
					}
				} else {
					_upgrade_desc += "All armor upgrades unlocked.";
					_upgrade_action = "MAX LEVEL";
					_upgrade_action_color = make_color_rgb(45, 51, 68);
				}
			}

			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_color(_selected ? _cyan : c_white);
			draw_text(_row_left + 14, _row_y + 10, _upgrade_title);
			draw_set_color(_muted);
			draw_text(_row_left + 14, _row_y + 34, "CURRENT LEVEL  " + string(_upgrade_level) + " / 4");
			draw_set_color(make_color_rgb(210, 220, 235));
			draw_text_ext(_row_left + 14, _row_y + 55, _upgrade_desc, 15, _panel_w - 236);

			draw_set_color(_upgrade_action_color);
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 28, _panel_x + _panel_w - 28, _row_y + 84, false);
			draw_set_color(_selected ? _magenta : make_color_rgb(85, 76, 122));
			draw_rectangle(_panel_x + _panel_w - 168, _row_y + 28, _panel_x + _panel_w - 28, _row_y + 84, true);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_text(_panel_x + _panel_w - 98, _row_y + 56, _upgrade_action);
		}

		if (shop_message_timer > 0) {
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(shop_message_color);
			draw_text(_gui_w * 0.5, _panel_y + _panel_h - 42, shop_message);
		}
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_color(_muted);
		draw_text(_gui_w * 0.5, _panel_y + _panel_h - 18, "UP / DOWN: Choose upgrade    ENTER or click price: Buy    ESC: Back");
	}

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_color(c_white);
}
