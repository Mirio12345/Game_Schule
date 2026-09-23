// obj_coin_fly - Draw_64 Event (GUI Layer)
// Draw the flying coin as a golden circle with optional number text

// Draw the coin circle with gold color
draw_set_alpha(alpha);

// Draw border
draw_set_color(coin_border_color);
draw_circle(gui_x, gui_y, coin_size + 1, false);

// Draw coin fill
draw_set_color(coin_color);
draw_circle(gui_x, gui_y, coin_size, false);

// Draw coin highlight (lighter gold for 3D effect)
draw_set_color(#FFF8DC);
draw_circle(gui_x - 2, gui_y - 2, coin_size * 0.4, false);

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