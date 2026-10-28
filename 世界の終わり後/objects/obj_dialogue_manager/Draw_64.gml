/// @description obj_dialogue_manager – Draw GUI
/// Draws the dialogue box, speaker name, typewriter text and [Space] prompt.

if (!active || box_alpha <= 0.01) exit;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _x = box_margin;
var _y = _gui_h - box_height - box_margin;
var _w = min(_gui_w - box_margin * 2, 720);

// Background
draw_set_alpha(box_alpha * box_bg_alpha);
draw_set_color(box_color);
draw_rectangle(_x, _y, _x + _w, _y + box_height, false);

// Border
draw_set_alpha(box_alpha);
draw_set_color(c_white);
draw_rectangle(_x, _y, _x + _w, _y + box_height, true);

// Speaker name
draw_set_font(dialogue_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(name_color);
draw_text(_x + 16, _y + 8, speaker_name);

// Dialogue text (typewriter)
draw_set_color(text_color);
var _visible = string_copy(dialogue_text, 1, char_index);
draw_text_ext(_x + 16, _y + 36, _visible, 24, _w - 32);

// "[Space]" prompt while the line is complete
if (line_complete) {
    draw_set_alpha(box_alpha * (0.5 + 0.5 * sin(current_time / 300)));
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(_x + _w - 16, _y + box_height - 8, "[Space]");
}

// Reset draw state
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);