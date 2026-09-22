event_inherited();

// Determine slot number from x position
var _slot = 1;
if (x > 400 && x < 700) { _slot = 2; }
if (x > 700) { _slot = 3; }

global.active_slot = _slot;

if (scr_save_game(_slot)) {
	Button_Text = "Save " + string(_slot) + ": " + scr_get_save_info(_slot);
	show_debug_message("Saved to slot " + string(_slot));
} else {
	show_debug_message("Failed to save to slot " + string(_slot));
}
