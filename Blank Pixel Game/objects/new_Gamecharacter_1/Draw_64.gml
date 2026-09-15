// --- HUD: Ausdauer- und Rüstungsleiste (oben links, komplett per Code
//     gezeichnet - kein zusätzliches Sprite-Asset nötig) ---
var _bar_x = 20;
var _bar_y = 20;
var _bar_w = 150;
var _bar_h = 10;
var _gap   = 16;

// Ausdauer
var _stamina_pct = clamp(stamina / global.staminaMax, 0, 1);
draw_set_color(c_black);
draw_rectangle(_bar_x - 2, _bar_y - 2, _bar_x + _bar_w + 2, _bar_y + _bar_h + 2, false);
draw_set_color(c_dkgray);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
draw_set_color(is_sprinting ? c_yellow : c_lime);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w * _stamina_pct, _bar_y + _bar_h, false);

// Rüstung
var _armor_y = _bar_y + _gap;
var _armor_pct = clamp(global.player_armor / global.max_player_armor, 0, 1);
draw_set_color(c_black);
draw_rectangle(_bar_x - 2, _armor_y - 2, _bar_x + _bar_w + 2, _armor_y + _bar_h + 2, false);
draw_set_color(c_dkgray);
draw_rectangle(_bar_x, _armor_y, _bar_x + _bar_w, _armor_y + _bar_h, false);
draw_set_color(c_aqua);
draw_rectangle(_bar_x, _armor_y, _bar_x + _bar_w * _armor_pct, _armor_y + _bar_h, false);

draw_set_color(c_white);

// Cooldown-/Perk-Anzeige
var _fps = max(1, game_get_speed(gamespeed_fps));
draw_set_font(-1);
draw_set_color(c_white);
draw_text(_bar_x, _armor_y + 20, "Z Armor 50%: " + (armor_perk_cooldown <= 0 ? "READY" : string_format(armor_perk_cooldown / _fps, 1, 1) + "s"));
draw_text(_bar_x, _armor_y + 36, "N One-Shot: " + (pierce_perk_timer > 0 ? "ACTIVE" : (pierce_perk_cooldown <= 0 ? "READY" : string_format(pierce_perk_cooldown / _fps, 1, 1) + "s")));
if (sprint_cooldown > 0)
    draw_text(_bar_x, _armor_y + 52, "Sprint: " + string_format(sprint_cooldown / _fps, 1, 1) + "s");

// --- Cutscene-Dialog beim Raumeintritt ---
if (banner_timer > 0)
{
    var _elapsed = banner_total - banner_timer;
    var _alpha = 1;
    if (_elapsed < banner_fade_in) _alpha = _elapsed / banner_fade_in;
    else if (banner_timer < banner_fade_out) _alpha = banner_timer / banner_fade_out;

    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();
    var _cx = _gw * 0.5;
    var _box_y1 = _gh * 0.68;
    var _box_y2 = _gh * 0.90;

    draw_set_alpha(_alpha * 0.82);
    draw_set_color(c_black);
    draw_rectangle(80, _box_y1, _gw - 80, _box_y2, false);

    draw_set_alpha(_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_aqua);
    draw_text(_cx, _box_y1 + 34, banner_text);
    draw_set_color(c_white);
    draw_text(_cx, _box_y1 + 72, banner_subtext);
    draw_set_color(c_ltgray);
    draw_text(_cx, _box_y2 - 22, "SPACE - überspringen");

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}
