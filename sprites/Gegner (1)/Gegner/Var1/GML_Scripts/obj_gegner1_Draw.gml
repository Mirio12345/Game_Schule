/// obj_gegner1 - Draw Event
draw_self();
// leichtes gruenes Leuchten (Aura)
gpu_set_blendmode(bm_add);
draw_set_alpha(0.12);
draw_set_color(make_color_rgb(125, 255, 42));
draw_circle(x, y - 20, rad_radius * 0.6, false);
draw_set_alpha(1); draw_set_color(c_white);
gpu_set_blendmode(bm_normal);
