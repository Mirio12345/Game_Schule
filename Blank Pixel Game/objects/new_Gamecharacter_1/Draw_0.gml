draw_self();

// Draw the equipped weapon from its grip origin and flip it for left-facing aim.
if (variable_global_exists("current_weapon") && variable_global_exists("weapon_sprites")) {
	var _weapon_count = array_length(global.weapon_sprites);
	if (_weapon_count <= 0) exit;
	var _weapon_slot = clamp(global.current_weapon, 0, _weapon_count - 1);
	var _aim_direction = point_direction(x, y, mouse_x, mouse_y);
	var _aiming_left = (_aim_direction > 90 && _aim_direction < 270);
	var _hand_offset_x = _aiming_left ? -global.weapon_hand_offset_x : global.weapon_hand_offset_x;
	var _weapon_scale = global.weapon_sprite_scales[_weapon_slot] * global.zoom_level_character;
	var _weapon_xscale = _aiming_left ? -_weapon_scale : _weapon_scale;
	var _weapon_angle = _aiming_left ? _aim_direction + 180 : _aim_direction;
	draw_sprite_ext(global.weapon_sprites[_weapon_slot], 0, x + _hand_offset_x, y + global.weapon_hand_offset_y, _weapon_xscale, _weapon_scale, _weapon_angle, c_white, 1);
}
