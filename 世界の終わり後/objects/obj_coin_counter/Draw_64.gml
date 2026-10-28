// obj_coin_counter - Draw_64 Event (GUI Layer)
// Draw the gold coin counter in the top-left corner
var _spr = sprite_index;
if (_spr != -1) {
	var _sw = sprite_get_width(_spr);
	if (_sw > 0) {
		var _s = (coin_size * 2) / _sw;
		draw_sprite_ext(_spr, 0, gui_x - coin_size, gui_y - coin_size, _s, _s, 0, c_white, 1);
	}
}
// Draw coin count text
draw_set_color(text_shadow_color);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text(gui_x + text_offset_x + 1, gui_y + 1, string(display_value));

draw_set_color(text_color);
draw_text(gui_x + text_offset_x, gui_y, string(display_value));

// Reset drawing properties
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);