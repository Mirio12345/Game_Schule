// SaveManager Draw Event - Show save slot info on SaveMenu screen

if (room == SaveMenu) {
	draw_set_font(Main_menu_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_white);
	
	// Section labels
	draw_text(560, 190, "--- Save Game ---");
	draw_text(560, 410, "--- Load Game ---");
	
	// Draw save info for each slot (below each button row)
	for (var i = 1; i <= 3; i++) {
		var _x = 240 + ((i - 1) * 320);
		
		if (scr_save_exists(i)) {
			var _info = scr_get_save_info(i);
			draw_text(_x, 310, "Slot " + string(i) + ": " + _info);
			draw_text(_x, 540, "Slot " + string(i) + ": " + _info);
		} else {
			draw_text(_x, 310, "Slot " + string(i) + ": Empty");
			draw_text(_x, 540, "Slot " + string(i) + ": Empty");
		}
	}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
}
