/// @description obj_dialogue_manager – Create
/// Persistent dialogue controller: typewriter text box for NPC dialogue.
/// NPCs start a dialogue with start_dialogue(lines, speaker).

// Exactly one manager may exist. Keep this instance and remove any other
// (e.g. left over from a room transition or a persisted room), so the
// current room is guaranteed to have a manager.
if (instance_number(object_index) > 1) {
    var _self_id = id;
    with (object_index) {
        if (id != _self_id) instance_destroy();
    }
}

if (!variable_global_exists("can_move")) global.can_move = true;

active = false;
dialogue_lines = [];
line_index = 0;
speaker_name = "";

dialogue_text = "";
char_index = 0;
char_timer = 0;
char_speed = 0.5;      // characters per frame
line_complete = false;
box_alpha = 0;

input_cooldown = 0;
input_cooldown_max = 12;

box_margin = 40;
box_height = 120;
box_color = c_black;
box_bg_alpha = 0.75;
text_color = c_white;
name_color = make_color_rgb(0, 240, 255);
dialogue_font = Main_menu_font;

start_dialogue = function(_lines, _speaker) {
    if (array_length(_lines) <= 0) return;
    dialogue_lines = _lines;
    speaker_name = _speaker;
    line_index = 0;
    dialogue_text = dialogue_lines[0];
    char_index = 0;
    char_timer = 0;
    line_complete = false;
    box_alpha = 0;
    input_cooldown = 10;
    active = true;
    global.can_move = false;
};