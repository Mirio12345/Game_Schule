// Armor-Kit: leuchtende Box + Schildsymbol, komplett in GML gezeichnet.
var _bob = sin(bob_timer) * 3;
var _cx = x;
var _cy = y + _bob;

// Schatten / Koffer
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(_cx - 18, _cy - 12 + 3, _cx + 18, _cy + 12 + 3, false);
draw_set_alpha(1);
draw_set_color(c_dkgray);
draw_rectangle(_cx - 18, _cy - 12, _cx + 18, _cy + 12, false);
draw_set_color(c_aqua);
draw_rectangle(_cx - 16, _cy - 10, _cx + 16, _cy + 10, true);

// Griff
draw_set_color(c_ltgray);
draw_rectangle(_cx - 7, _cy - 16, _cx + 7, _cy - 11, true);

// Schild-Icon
draw_set_color(c_aqua);
draw_triangle(_cx - 8, _cy - 6, _cx + 8, _cy - 6, _cx, _cy + 9, false);
draw_set_color(c_white);
draw_circle(_cx, _cy - 1, 2, false);

// kleine Leuchtkante
draw_set_alpha(0.25 + 0.15 * sin(bob_timer * 1.7));
draw_set_color(c_aqua);
draw_circle(_cx, _cy, 23, true);
draw_set_alpha(1);
draw_set_color(c_white);
