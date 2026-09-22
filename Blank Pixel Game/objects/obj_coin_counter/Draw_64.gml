// obj_coin_counter - Draw_64 Event (GUI Layer)
// Draw the gold coin counter in the top-left corner

// Draw coin icon (golden circle)
// Border
draw_set_color(coin_border_color);
draw_circle(gui_x, gui_y, coin_size + 1, false);

// Fill
draw_set_color(coin_color);
draw_circle(gui_x, gui_y, coin_size, false);

// Highlight
draw_set_color(#FFF8DC);
draw_circle(gui_x - 2, gui_y - 2, coin_size * 0.4, false);

// Draw coin count text
draw_set_color(text_shadow_color);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text(gui_x + text_offset_x + 1, gui_y + 1, string(display_value));

draw_set_color(text_color);
draw_text(gui_x + text_offset_x, gui_y, string(display_value));
	// --- Equipped weapon ---
	var _equip_y = gui_y + 22;
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(gui_x + 1, _equip_y + 1, "Weapon: " + global.weapon_names[global.current_weapon]);
	draw_set_color(make_color_rgb(200, 200, 220));
	draw_text(gui_x, _equip_y, "Weapon: " + global.weapon_names[global.current_weapon]);

	// --- Equipped armor ---
	var _armor_y = _equip_y + 16;
	var _armor_txt = "Armor: ";
	if (global.current_armor >= 0) {
		_armor_txt += global.armor_names[global.current_armor];
	} else {
		_armor_txt += "None";
	}
	draw_set_color(c_black);
	draw_text(gui_x + 1, _armor_y + 1, _armor_txt);
	draw_set_color(make_color_rgb(200, 200, 220));
	draw_text(gui_x, _armor_y, _armor_txt);

	// --- Speed boost timer ---
	if (global.speed_boost_timer > 0) {
		var _boost_y = _armor_y + 18;
		var _boost_secs = string(ceil(global.speed_boost_timer / 60));
		var _boost_txt = "SPEED +" + _boost_secs + "s";
		draw_set_color(c_black);
		draw_text(gui_x + 1, _boost_y + 1, _boost_txt);
		draw_set_color(make_color_rgb(80, 255, 120));
		draw_text(gui_x, _boost_y, _boost_txt);
	}

	// --- Cigarette items ---
	var _cig_y = _armor_y + 36;
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	// Default cigarette icon + count
	if (global.item_counts[0] > 0) {
		draw_sprite(s_cig_default, 0, gui_x, _cig_y);
		draw_set_color(c_black);
		draw_text(gui_x + 35, _cig_y + 4, "x" + string(global.item_counts[0]));
		draw_set_color(make_color_rgb(220, 200, 170));
		draw_text(gui_x + 34, _cig_y + 3, "x" + string(global.item_counts[0]));
	}

	// Green cigarette icon + count
	if (global.item_counts[1] > 0) {
		var _green_x = gui_x + 55;
		draw_sprite(s_cig_green, 0, _green_x, _cig_y);
		draw_set_color(c_black);
		draw_text(_green_x + 35, _cig_y + 4, "x" + string(global.item_counts[1]));
		draw_set_color(make_color_rgb(120, 255, 140));
		draw_text(_green_x + 34, _cig_y + 3, "x" + string(global.item_counts[1]));
	}
// Reset drawing properties
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);