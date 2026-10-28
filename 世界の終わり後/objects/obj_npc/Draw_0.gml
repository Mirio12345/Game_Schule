/// @description obj_npc – Draw
draw_self();

if (show_prompt) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(0, 240, 255));
    draw_text(x, y - sprite_height - 6, "[E] Talk");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}