draw_self()
frame = global.player_hp
max_player_hp = global.max_player_hp
var hp_percent = frame / max_player_hp;

hp_percent = clamp(hp_percent, 0, 1);


image_index = hp_percent * (image_number - 1);

var _target = hp_percent;
display_hp = lerp(display_hp, _target, 0.15);
trail_hp = max(_target, lerp(trail_hp, _target, trail_speed));

// Update max in case it changes
display_max_hp = global.max_player_hp;

// Glow pulse when damaged
if (_target < display_hp - 0.01) {
    glow_alpha = lerp(glow_alpha, 1, 0.15);
} else {
    glow_alpha = lerp(glow_alpha, 0, 0.04);
}
glow_pulse += 0.05;

if (variable_global_exists("chest_ammo_reward_timer") && global.chest_ammo_reward_timer > 0) {
	global.chest_ammo_reward_timer--;
}
