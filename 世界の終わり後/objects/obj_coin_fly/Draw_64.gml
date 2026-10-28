// obj_coin_fly - Draw_64 Event (GUI Layer)
// Draw the flying coin as the Amin_Gold_coin sprite with optional number text

// Draw the coin sprite
draw_set_alpha(alpha);
var _spr = sprite_index;
if (_spr != -1) {
	var _sw = sprite_get_width(_spr);
	if (_sw > 0) {
		var _s = (coin_size * 2) / _sw;
		draw_sprite_ext(_spr, 0, gui_x - coin_size, gui_y - coin_size, _s, _s, 0, c_white, alpha);
	}
}

// Draw coin number (optional - show coin_value)
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1); // Use default font
draw_text(gui_x, gui_y, string(coin_value));

// Reset drawing properties
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);