var b=sin(pulse)*3;
draw_set_color(c_black); draw_rectangle(x-22,y-16+b,x+22,y+16+b,false);
draw_set_color(c_dkgray); draw_rectangle(x-20,y-14+b,x+20,y+14+b,false);
draw_set_color(c_aqua); draw_rectangle(x-17,y-11+b,x+17,y+11+b,true);
draw_set_color(c_white); draw_set_halign(fa_center); draw_text(x,y-4+b,string_upper(weapon_id)); draw_set_halign(fa_left); draw_set_color(c_white);
