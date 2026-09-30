// BAZAR Shop - Draw GUI Event

var _show_notif = (notif_timer > 0 && notif_text != "");
if (anim_state == 0 && !_show_notif) exit;

// --- Scaled dialog dimensions ---
var _scale = anim_scale;
var _dw = dialog_width  * _scale;
var _dh = dialog_height * _scale;
var _dx = (display_get_gui_width()  - _dw) / 2;
var _dy = (display_get_gui_height() - _dh) / 2;

// --- Determine item count and names from globals ---
var _count = 0;
if (shop_tab == 0) {
	_count = array_length(global.armor_names);
} else {
	_count = array_length(global.weapon_names);
}

// --- Semi-transparent backdrop (only when dialog is visible) ---
if (_scale > 0.01) {
	draw_set_alpha(0.5 * anim_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);

	// --- Dialog border ---
	draw_set_alpha(anim_alpha);
	draw_set_color(make_color_rgb(40, 40, 50));
	draw_rectangle(_dx - 4, _dy - 4, _dx + _dw + 4, _dy + _dh + 4, false);

	// --- Dialog background ---
	draw_set_color(make_color_rgb(20, 20, 30));
	draw_rectangle(_dx, _dy, _dx + _dw, _dy + _dh, false);

	// --- Title ---
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(-1);
	draw_set_color(make_color_rgb(255, 215, 0));
	draw_text(_dx + _dw / 2, _dy + 12, "SHOP");

	// --- Coin display at top-right ---
	draw_set_halign(fa_right);
	draw_set_color(make_color_rgb(255, 215, 0));
	draw_text(_dx + _dw - 16, _dy + 12, string(global.gold_coins) + " Coins");

	// --- Tabs ---
	var _tab_w = 100;
	var _tab_h = 26;
	var _tab_y = _dy + 36;
	var _tab_gap = 4;
	var _total_tabs_w = 2 * _tab_w + 1 * _tab_gap;
	var _tab_start_x = _dx + (_dw - _total_tabs_w) / 2;
	var _tab_labels = ["ARMOR", "WEAPONS"];
	var _tab_xs = [_tab_start_x, _tab_start_x + _tab_w + _tab_gap];

	for (var t = 0; t < 2; t++) {
		var _tx = _tab_xs[t];
		var _active = (shop_tab == t);

		if (_active) {
			draw_set_alpha(0.4);
			draw_set_color(make_color_rgb(255, 215, 0));
		} else {
			draw_set_alpha(0.15);
			draw_set_color(make_color_rgb(150, 150, 170));
		}
		draw_rectangle(_tx, _tab_y, _tx + _tab_w, _tab_y + _tab_h, false);
		draw_set_alpha(1);

		draw_set_color(make_color_rgb(80, 80, 100));
		draw_rectangle(_tx, _tab_y, _tx + _tab_w, _tab_y + _tab_h, true);

		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		if (_active) {
			draw_set_color(make_color_rgb(255, 215, 0));
		} else {
			draw_set_color(make_color_rgb(150, 150, 170));
		}
		draw_text(_tx + _tab_w / 2, _tab_y + _tab_h / 2, _tab_labels[t]);
	}

	// --- Divider line ---
	var _div_y = _tab_y + _tab_h + 6;
	draw_set_color(make_color_rgb(80, 80, 100));
	draw_line(_dx + 20, _div_y, _dx + _dw - 20, _div_y);

	// --- Current info line ---
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(make_color_rgb(150, 150, 170));
	if (shop_tab == 0) {
		var _atxt = "Equipped: ";
		if (global.current_armor >= 0) {
			_atxt += global.armor_names[global.current_armor] + " (" + string(global.armor_level) + "% Resist)";
		} else {
			_atxt += "None";
		}
		draw_text(_dx + _dw / 2, _div_y + 8, _atxt);
	} else {
		var _wname = global.weapon_names[global.current_weapon];
		draw_text(_dx + _dw / 2, _div_y + 8, "Equipped: " + _wname);
	}

	// --- Exponential pricing info ---
	draw_set_color(make_color_rgb(180, 140, 80));
	draw_set_halign(fa_right);
	draw_text(_dx + _dw - 16, _div_y + 8, "Purchases: " + string(global.total_purchases));
	draw_set_halign(fa_center);

	// --- Shop items ---
	var _item_y = _div_y + 28;
	var _item_h = 88;
	var _item_pad = 10;
	var _item_w = _dw - 50;

	for (var i = 0; i < _count; i++) {
		var _iy = _item_y + i * (_item_h + _item_pad);
		var _sel = (i == shop_selected);

		// Highlight background for selected item
		if (_sel) {
			draw_set_alpha(0.25);
			draw_set_color(make_color_rgb(255, 215, 0));
			draw_rectangle(_dx + 20, _iy, _dx + 20 + _item_w, _iy + _item_h, false);
			draw_set_alpha(1);
		}

		// Selection indicator
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if (_sel) {
			draw_set_color(make_color_rgb(255, 215, 0));
			draw_text(_dx + 26, _iy + 4, ">");
		}

		// Determine owned & equipped status + price
		var _owned = false;
		var _equipped = false;
		var _item_name = "";
		var _item_desc = "";
		var _base_cost = 0;
		var _price = 0;

		if (shop_tab == 0) {
			_owned = global.owned_armors[i];
			_equipped = (i == global.current_armor);
			_item_name = global.armor_names[i];
			_item_desc = string(global.armor_resists[i]) + "% Damage Resistance";
			_base_cost = global.armor_base_costs[i];
			_price = scr_shop_price(_base_cost);
		} else if (shop_tab == 1) {
			_owned = global.owned_weapons[i];
			_equipped = (i == global.current_weapon);
			_item_name = global.weapon_names[i];
			// Build description from stats
			var _dmg_pct = round((global.weapon_dmg_mults[i] - 1) * 100);
			var _spd_pct = round((1 - global.weapon_spd_mults[i]) * 100);
			if (_dmg_pct == 0 && _spd_pct == 0) {
				_item_desc = "Standard Sidearm - No Bonus";
			} else {
				_item_desc = "";
				if (_dmg_pct > 0) _item_desc += "+" + string(_dmg_pct) + "% Damage";
				if (_spd_pct > 0) {
					if (_item_desc != "") _item_desc += ", ";
					_item_desc += "+" + string(_spd_pct) + "% Fire Rate";
				}
			}
			_base_cost = global.weapon_base_costs[i];
			_price = scr_shop_price(_base_cost);
		}

		// Item name color
		var _name_color;
		if (_equipped) {
			_name_color = make_color_rgb(255, 215, 0);  // Gold = equipped
		} else if (_owned) {
			_name_color = make_color_rgb(100, 200, 100);  // Green = owned
		} else if (_sel) {
			_name_color = c_white;
		} else {
			_name_color = make_color_rgb(200, 200, 210);
		}
		draw_set_color(_name_color);
		draw_text(_dx + 42, _iy + 6, _item_name);

		// Description
		draw_set_color(make_color_rgb(150, 150, 170));
		draw_text(_dx + 42, _iy + 24, _item_desc);

		// Cost (right side, top)
		draw_set_halign(fa_right);
		if (_owned) {
			// No cost shown for owned items
		} else if (global.gold_coins >= _price) {
			draw_set_color(make_color_rgb(255, 215, 0));
			draw_text(_dx + 20 + _item_w, _iy + 6, string(_price) + " Coins");
		} else {
			draw_set_color(make_color_rgb(120, 60, 60));
			draw_text(_dx + 20 + _item_w, _iy + 6, string(_price) + " Coins");
		}

		// Status tag (right side, middle)
		draw_set_halign(fa_right);
		if (shop_tab == 2) {
			// Items tab: show quantity
			var _qty = global.item_counts[i];
			if (_qty > 0) {
				draw_set_color(make_color_rgb(100, 200, 100));
				draw_text(_dx + 20 + _item_w, _iy + 24, "x" + string(_qty) + " Owned");
			} else if (global.gold_coins < _price) {
				drolor(make_color_rgb(120, 60, 60));
			draw_text(_dx + 20 + _item_w, _iy + 24, "TOO POOR");
		} else if (_sel) {
			draw_set_color(make_color_rgb(100, 200, 255));
			draw_text(_dx + 20 + _item_w, _iy + 24, "[ENTER] Buy");
		}

		// Action hint (right side, bottom)
		if (_sel && _owned && !_equipped) {
			draw_set_halign(fa_right);
			draw_set_color(make_color_rgb(100, 200, 255));
			draw_text(_dx + 20 + _item_w, _iy + 42, "[ENTER] Equip");
		}
		if (_sel && _equipped && (shop_tab == 0 || shop_tab == 1)) {
			draw_set_halign(fa_right);
			draw_set_color(make_color_rgb(180, 180, 100));
			draw_text(_dx + 20 + _item_w, _iy + 42, "[ENTER] Unequip");
		}
	}

	// --- Controls hint at bottom ---
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(make_color_rgb(120, 120, 140));
	draw_text(_dx + _dw / 2, _dy + _dh - 14, "TAB: Switch Tab    UP/DOWN: Navigate    ENTER: Buy/Equip    F/ESC: Close");

} // end if (_scale > 0.01)

// --- Notification bar (draws even when dialog is closed) ---
if (_show_notif) {
	var _full_dw = dialog_width;
	var _full_dh = dialog_height;
	var _full_dx = (display_get_gui_width()  - _full_dw) / 2;
	var _full_dy = (display_get_gui_height() - _full_dh) / 2;
	var _nb_y = _full_dy + _full_dh - 56;
	var _nb_h = 28;
	
	draw_set_alpha(0.85);
	draw_set_color(make_color_rgb(30, 30, 40));
	draw_rectangle(_full_dx + 20, _nb_y, _full_dx + _full_dw - 20, _nb_y + _nb_h, false);
	draw_set_alpha(1);
	
	draw_set_color(notif_color);
	draw_rectangle(_full_dx + 20, _nb_y, _full_dx + _full_dw - 20, _nb_y + _nb_h, true);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(notif_color);
	draw_text(_full_dx + _full_dw / 2, _nb_y + _nb_h / 2, notif_text);
}

// --- Reset drawing state ---
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);
}