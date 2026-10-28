image_speed = 0;
image_index = 0;

// Unique ID for this chest (use position-based ID for multiple chests)
chest_id = "chest_" + string(round(x)) + "_" + string(round(y));

// Ensure save globals exist
if (!variable_global_exists("chest_states")) { global.chest_states = {}; }

// Check if this chest was already opened in a save
if (variable_struct_exists(global.chest_states, chest_id)) {
	if (global.chest_states[$ chest_id]) {
		chest_status = 1;
		image_index = 1;
	}
} else {
	chest_status = 0;
}