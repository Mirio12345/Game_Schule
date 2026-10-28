/// obj_npc_bazarmen - Draw Event
draw_self();
var _p = instance_nearest(x, y, obj_player);
if (_p != noone && point_distance(x, y, _p.x, _p.y) < interact_range && !shop_open) {
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(0, 240, 255));
    draw_text(x, y - 40, "[E] Handeln");
    draw_set_color(c_white);
    draw_set_halign(fa_left);
}
