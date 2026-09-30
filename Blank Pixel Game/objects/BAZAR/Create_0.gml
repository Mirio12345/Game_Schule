// BAZAR Shop - Create Event

shop_open = false;
shop_selected = 0;
shop_tab = 0;  // 0 = Armor, 1 = Weapons

// Interaction range (pixels)
interact_range = 60;

// Dialog visual properties (fullscreen)
dialog_width  = display_get_gui_width();
dialog_height = display_get_gui_height();

// Animation system (scale + fade, ~1 second at 60fps)
anim_state  = 0;  // 0 = idle/closed, 1 = opening, 2 = open, 3 = closing
anim_scale  = 0;  // 0 = fully closed, 1 = fully open
anim_alpha  = 0;  // 0 = invisible, 1 = fully visible
anim_speed  = 0.04; // lerp factor per frame (~1 sec to reach target)

// Notification system
notif_text  = "";
notif_timer = 0;
notif_color = c_white;
