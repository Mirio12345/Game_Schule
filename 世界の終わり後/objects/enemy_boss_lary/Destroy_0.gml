// enemy_boss_lary - Destroy Event
// When this boss dies, add gold coins and spawn flying coin animations

// Add gold coins to global
global.gold_coins += global.enemy_boss_lary_coins;

// Calculate number of flying coins to spawn (each coin represents 5)
var _num_coins = max(1, ceil(global.enemy_boss_lary_coins / 5));

// Spawn flying coins with staggered delays
for (var i = 0; i < _num_coins; i++) {
	var _coin = instance_create_depth(x, y, -1000, obj_coin_fly);
	_coin.start_x = x + irandom_range(-10, 10);
	_coin.start_y = y + irandom_range(-10, 10);
	_coin.start_gui_x = _coin.start_x - camera_get_view_x(view_camera[0]);
	_coin.start_gui_y = _coin.start_y - camera_get_view_y(view_camera[0]);
	_coin.target_gui_x = 20;
	_coin.target_gui_y = 20;
	_coin.fly_delay = i * 5;
	_coin.coin_value = 5;
}