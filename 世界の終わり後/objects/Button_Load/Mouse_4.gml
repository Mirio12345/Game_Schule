event_inherited();

// Determine slot number from x position
var _slot = 1;
if (x > 400 && x < 700) { _slot = 2; }
if (x > 700) { _slot = 3; }

global.active_slot = _slot;

if (scr_save_exists(_slot)) {
	if (scr_load_game(_slot)) {
		show_debug_message("Loaded from slot " + string(_slot));
	} else {
		show_debug_message("Failed to load from slot " + string(_slot));
	}
} else {
	show_debug_message("No save in slot " + string(_slot));
	Button_Text = "Load " + string(_slot) + ": Empty";
}
