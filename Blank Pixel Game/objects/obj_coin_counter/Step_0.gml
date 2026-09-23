// obj_coin_counter - Step Event
// Animate the coin counter value

// Animate display value towards target value
if (display_value < target_value) {
	display_value = min(display_value + count_speed, target_value);
}

// Update target value from global
target_value = global.gold_coins;