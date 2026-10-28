/// obj_gegner2 - Draw Event
draw_self();
// Neon-Schein unter den Fuessen
gpu_set_blendmode(bm_add);
draw_set_alpha(0.15);
draw_set_color(make_color_rgb(0, 240, 255));
draw_ellipse(x - 12, y - 3, x + 12, y + 3, false);
draw_set_alpha(1); draw_set_color(c_white);
gpu_set_blendmode(bm_normal);