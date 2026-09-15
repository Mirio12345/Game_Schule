if (!visible_menu) exit;
var gw=display_get_gui_width(), gh=display_get_gui_height();
draw_set_alpha(0.94); draw_set_color(c_black); draw_rectangle(70,55,gw-70,gh-55,false); draw_set_alpha(1);
draw_set_color(c_aqua); draw_set_halign(fa_center); draw_text(gw/2,85,"SAVE / LOAD");
draw_set_color(c_white); draw_text(gw/2,112,"F6 close   |   1/2/3 select slot   |   S save   |   L load   |   DELETE delete");
for(var i=1;i<=3;i++){
    var cx=180+(i-1)*500, sy=175; var inf=save_slot_info(i);
    draw_set_color(i==selected_slot ? c_aqua : c_dkgray); draw_rectangle(cx,sy,cx+430,sy+180,false);
    draw_set_color(c_white); draw_text(cx+20,sy+20,inf.label); draw_text(cx+20,sy+60,"Area: "+inf.area); draw_text(cx+20,sy+90,"Checkpoint: "+inf.checkpoint); draw_text(cx+20,sy+120,"Playtime: "+inf.playtime);
}
if(message_timer>0){draw_set_color(c_lime); draw_text(gw/2,gh-95,message);}
draw_set_halign(fa_left); draw_set_color(c_white);
