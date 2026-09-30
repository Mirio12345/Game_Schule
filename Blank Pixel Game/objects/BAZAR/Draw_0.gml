// Draw the NPC sprite and a readable name label above his head.
draw_self();

var _label_y = bbox_top - 8;
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

draw_set_color(c_black);
draw_text(x + 1, _label_y + 1, "bazarmen");
draw_set_color(make_color_rgb(255, 215, 0));
draw_text(x, _label_y, "bazarmen");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
