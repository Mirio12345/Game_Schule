event_inherited();

// Delete all save files
scr_delete_save(1);
scr_delete_save(2);
scr_delete_save(3);

// Reset active slot
global.active_slot = 0;

show_debug_message("All saves deleted");
