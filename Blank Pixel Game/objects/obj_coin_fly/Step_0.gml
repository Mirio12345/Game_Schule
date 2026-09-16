// obj_coin_fly - Step Event
// Move the coin from start position to target (HUD counter)

// Handle delay before flying starts
if (fly_delay > 0) {
	fly_delay--;
	exit;
}

// Update progress
fly_progress += fly_speed;

// Calculate current position with arc (GUI space)
var _current_x = lerp(start_gui_x, target_gui_x, fly_progress);
var _current_y = lerp(start_gui_y, target_gui_y, fly_progress);

// Add arc/curve to the movement (sin wave)
var _arc_offset = sin(fly_progress * pi) * fly_arc_height;

// Update GUI position for rendering
gui_x = _current_x;
gui_y = _current_y + _arc_offset;

// Fade out as we approach target
if (fly_progress > 0.7) {
	alpha = lerp(1, 0, (fly_progress - 0.7) / 0.3);
}

// Check if we've arrived at the target
if (fly_progress >= 1) {
	is_arrived = true;
	instance_destroy(self);
}