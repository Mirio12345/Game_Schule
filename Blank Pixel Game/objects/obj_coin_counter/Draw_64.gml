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

// Reset drawing properties
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);