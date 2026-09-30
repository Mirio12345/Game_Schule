var draw_x = 20;
var draw_y = 650;

var _gw = display_get_gui_width();

// --- Bar config ---
var _bx = bar_x;
var _by = bar_y;
var _bw = bar_w;
var _bh = bar_h;
var _radius = bar_radius;

// --- Background ---
draw_set_alpha(0.6);
draw_set_color(make_color_rgb(10, 10, 18));
draw_rectangle(_bx - 2, _by - 2, _bx + _bw + 2, _by + _bh + 2, false);
draw_set_alpha(1);

// --- Damage trail (red/amber bar behind) ---
var _trail_w = _bw * max(trail_hp, 0);
if (_trail_w > 0) {
    draw_set_color(make_color_rgb(160, 60, 60));
    draw_rectangle(_bx, _by, _bx + _trail_w, _by + _bh, false);
}

// --- Main HP bar ---
var _fill_w = _bw * clamp(display_hp, 0, 1);

// Color based on HP level (green -> yellow -> red)
var _bar_color;
var _pct = display_hp;
if (_pct > 0.5) {
    _bar_color = make_color_rgb(70, 220, 100);   // healthy green
} else if (_pct > 0.25) {
    _bar_color = make_color_rgb(230, 200, 50);   // warning yellow
} else {
    _bar_color = make_color_rgb(230, 60, 60);    // danger red
}

if (_fill_w > 0) {
    draw_set_color(_bar_color);
    draw_rectangle(_bx, _by, _bx + _fill_w, _by + _bh, false);
}

// --- Top highlight (shine) ---
draw_set_alpha(0.15);
draw_set_color(c_white);
draw_rectangle(_bx, _by, _bx + _fill_w, _by + 5, false);
draw_set_alpha(1);

// --- Glow when taking damage ---
if (glow_alpha > 0.01) {
    var _glow = sin(glow_pulse) * 0.3 + 0.7;
    draw_set_alpha(glow_alpha * 0.35 * _glow);
    draw_set_color(make_color_rgb(255, 80, 80));
    draw_rectangle(_bx - 3, _by - 3, _bx + _bw + 3, _by + _bh + 3, false);
    draw_set_alpha(1);
}

// --- Border ---
draw_set_color(make_color_rgb(60, 60, 80));
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, true);
draw_set_color(make_color_rgb(35, 35, 50));
draw_rectangle(_bx - 1, _by - 1, _bx + _bw + 1, _by + _bh + 1, true);

// --- HP text ---
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(-1);
draw_text(_bx + _bw + 10, _by + _bh / 2,
    string(ceil(display_hp * display_max_hp)) + " / " + string(display_max_hp));

// --- "HP" label ---
draw_set_halign(fa_left);
draw_set_color(make_color_rgb(180, 180, 200));
draw_text(_bx, _by - 10, "HP");

// Keep the ammo display attached to the HP bar so it stays easy to find.
var _weapon_slot = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
var _weapon_magazine = global.weapon_magazine_sizes[_weapon_slot];
var _weapon_ammo_now = global.weapon_ammo[_weapon_slot];
var _weapon_reserve = global.weapon_reserve_ammo[_weapon_slot];
var _player = instance_find(new_Gamecharacter_1, 0);
var _near_checkpoint = scr_player_near_checkpoint(_player);
var _weapon_box_x = _bx;
var _weapon_box_y = _by - 104;
var _weapon_box_w = _bw;
var _weapon_box_h = 82;
var _ammo_color = c_aqua;
if (_weapon_ammo_now <= 0) _ammo_color = c_red;
else if (_weapon_ammo_now <= ceil(_weapon_magazine * 0.25)) _ammo_color = c_yellow;

draw_set_alpha(0.90);
draw_set_color(c_black);
draw_rectangle(_weapon_box_x, _weapon_box_y, _weapon_box_x + _weapon_box_w, _weapon_box_y + _weapon_box_h, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(60, 60, 80));
draw_rectangle(_weapon_box_x, _weapon_box_y, _weapon_box_x + _weapon_box_w, _weapon_box_y + _weapon_box_h, true);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(180, 180, 200));
draw_text(_weapon_box_x + 10, _weapon_box_y + 6, string_upper(global.weapon_names[_weapon_slot]));
draw_set_color(_ammo_color);
draw_text(_weapon_box_x + 10, _weapon_box_y + 23, string(_weapon_ammo_now) + " / " + string(_weapon_magazine));
draw_set_color(c_white);
draw_text(_weapon_box_x + 90, _weapon_box_y + 27, "RESERVE " + string(_weapon_reserve));

var _reload_time = 0;
var _reload_duration = 1.3;
if (instance_exists(_player)) {
	_reload_time = _player.weapon_reload_time;
	_reload_duration = _player.weapon_reload_duration;
}
if (_reload_time > 0) {
	var _reload_bar_x = _weapon_box_x + 10;
	var _reload_bar_y = _weapon_box_y + 45;
	var _reload_bar_w = _weapon_box_w - 20;
	var _reload_progress = 1 - _reload_time / _reload_duration;
	draw_set_color(c_dkgray);
	draw_rectangle(_reload_bar_x, _reload_bar_y, _reload_bar_x + _reload_bar_w, _reload_bar_y + 7, false);
	draw_set_color(c_aqua);
	draw_rectangle(_reload_bar_x, _reload_bar_y, _reload_bar_x + _reload_bar_w * _reload_progress, _reload_bar_y + 7, false);
	draw_set_color(c_white);
	draw_text(_reload_bar_x, _weapon_box_y + 58, "RELOADING " + string_format(_reload_time, 1, 1) + "s");
} else {
	var _weapon_hint = "R  RELOAD";
	if (_near_checkpoint) _weapon_hint = "R  CHECKPOINT";
	else if (_weapon_reserve > 0 && _weapon_ammo_now >= _weapon_magazine) _weapon_hint = "MAGAZINE FULL";
	else if (_weapon_reserve <= 0 && _weapon_ammo_now <= 0) _weapon_hint = "EMPTY  |  NO RESERVE AMMO";
	else if (_weapon_reserve <= 0) _weapon_hint = "NO RESERVE AMMO";
	draw_set_color(c_ltgray);
	draw_text(_weapon_box_x + 10, _weapon_box_y + 56, _weapon_hint);
}

if (variable_global_exists("chest_ammo_reward_timer") && global.chest_ammo_reward_timer > 0) {
	draw_set_color(c_aqua);
	draw_text(_weapon_box_x + 10, _weapon_box_y + 70, "CHEST AMMO +" + string(global.chest_ammo_reward_amount));
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);
