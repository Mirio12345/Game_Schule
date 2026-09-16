schon_geloescht1 = false;
schon_geloescht2 = false;

// Ensure save globals exist
if (!variable_global_exists("door_states")) { global.door_states = {}; }

// Restore door states from save
if (variable_struct_exists(global.door_states, "door1")) {
	if (global.door_states.door1) {
		if (instance_exists(sealed_door1)) { instance_destroy(sealed_door1); }
		schon_geloescht1 = true;
	}
}
if (variable_struct_exists(global.door_states, "door2")) {
	if (global.door_states.door2) {
		if (instance_exists(sealed_door2)) { instance_destroy(sealed_door2); }
		schon_geloescht2 = true;
	}
}