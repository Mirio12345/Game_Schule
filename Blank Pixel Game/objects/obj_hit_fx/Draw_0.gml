draw_set_alpha(life/10);
for (var i=0;i<amount;i++) {
    var a = i * (360/amount) + life*3;
    draw_circle(x+lengthdir_x(10,a), y+lengthdir_y(10,a), crit ? 2.5 : 1.5, false);
}
draw_set_alpha(1);
