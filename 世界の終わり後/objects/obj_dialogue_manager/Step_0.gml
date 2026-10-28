/// @description obj_dialogue_manager – Step
/// Typewriter reveal, line advancing (Space/Enter), dialogue end.

if (!active) exit;

if (input_cooldown > 0) input_cooldown--;

// Typewriter effect
if (!line_complete) {
    char_timer += char_speed;
    char_index = min(floor(char_timer), string_length(dialogue_text));
    if (char_index >= string_length(dialogue_text)) {
        char_index = string_length(dialogue_text);
        line_complete = true;
    }
}

// Box fade-in
if (box_alpha < 1) box_alpha = min(box_alpha + 0.05, 1);

// Ignore input while the inventory is open (it uses Space/Enter itself)
var _inv_open = variable_global_exists("inventory_open") && global.inventory_open;
if (_inv_open) exit;

var _advance = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
if (_advance && input_cooldown <= 0) {
    input_cooldown = input_cooldown_max;

    if (!line_complete) {
        // Skip typewriter: reveal the whole line at once
        char_index = string_length(dialogue_text);
        char_timer = char_index;
        line_complete = true;
    } else if (line_index < array_length(dialogue_lines) - 1) {
        // Next line
        line_index++;
        dialogue_text = dialogue_lines[line_index];
        char_index = 0;
        char_timer = 0;
        line_complete = false;
        box_alpha = 0;
    } else {
        // End of dialogue
        active = false;
        dialogue_lines = [];
        line_index = 0;
        dialogue_text = "";
        box_alpha = 0;
        global.can_move = true;
    }
}