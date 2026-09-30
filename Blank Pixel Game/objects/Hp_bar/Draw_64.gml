/// HP Bar - Draw GUI Event

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