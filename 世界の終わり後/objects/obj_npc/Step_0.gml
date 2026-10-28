/// @description obj_npc – Step
/// Show an [E] prompt when the player is close, start the dialogue on E.

var _p = instance_nearest(x, y, new_Gamecharacter_1);
var _near = (_p != noone) && point_distance(x, y, _p.x, _p.y) < interact_range;

var _blocked = (variable_global_exists("can_move") && global.can_move == false)
            || (instance_exists(obj_cutscene_coma))
            || (variable_global_exists("inventory_open") && global.inventory_open)
            || !instance_exists(obj_dialogue_manager)
            || obj_dialogue_manager.active;

show_prompt = _near && !_blocked;

if (show_prompt && keyboard_check_pressed(ord("E"))) {
    with (obj_dialogue_manager) {
        start_dialogue(other.dialogue_lines, other.npc_name);
    }
}

// Directional NPCs (with spr_idle/spr_walk set) face the player when near
if (_near && variable_instance_exists(id, "spr_idle")) {
    var _a = point_direction(x, y, _p.x, _p.y);
    facing = round(_a / 90) mod 4;
    sprite_index = spr_idle[facing];
    image_speed = 0.15;
}