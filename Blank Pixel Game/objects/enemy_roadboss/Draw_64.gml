// Boss health and wave indicator, fixed to the top-center of the screen.
var _gui_width = display_get_gui_width();
var _bar_width = min(480, _gui_width - 40);
var _bar_height = 20;
var _bar_x = (_gui_width - _bar_width) * 0.5;
var _bar_y = 42;
var _hp_ratio = clamp(hp / max(boss_max_hp, 1), 0, 1);
var _fill_width = _bar_width * _hp_ratio;

draw_set_alpha(1);
draw_set_color(make_color_rgb(12, 12, 18));
draw_rectangle(_bar_x - 4, _bar_y - 4, _bar_x + _bar_width + 4, _bar_y + _bar_height + 4, false);

draw_set_color(make_color_rgb(90, 30, 35));
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false);

if (_fill_width > 0) {
	var _fill_color = make_color_rgb(220, 55, 55);
	if (boss_phase == 2) _fill_color = make_color_rgb(240, 125, 35);
	else if (boss_phase == 3) _fill_color = make_color_rgb(245, 45, 70);
	draw_set_color(_fill_color);
	draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_width, _bar_y + _bar_height, false);
}

draw_set_color(c_white);
draw_rectangle(_bar_x - 2, _bar_y - 2, _bar_x + _bar_width + 2, _bar_y + _bar_height + 2, true);

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(_gui_width * 0.5, 20, "BOSS  -  WAVE " + string(boss_phase) + " / 3");
draw_text(_gui_width * 0.5, _bar_y + _bar_height * 0.5,
	string(max(0, ceil(hp))) + " / " + string(boss_max_hp));

// Leave the common GUI draw state at its defaults for other HUD elements.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);
