if (keyboard_check_pressed(vk_f6)) visible_menu=!visible_menu;
if (!visible_menu) exit;
if (keyboard_check_pressed(ord("1"))) selected_slot=1;
if (keyboard_check_pressed(ord("2"))) selected_slot=2;
if (keyboard_check_pressed(ord("3"))) selected_slot=3;
if (keyboard_check_pressed(ord("S"))) { message=save_slot(selected_slot) ? "SAVED" : "SAVE ERROR"; message_timer=90; }
if (keyboard_check_pressed(ord("L"))) { if (save_slot(selected_slot)) { message="LOADED"; message_timer=90; } else { message="NO SAVE"; message_timer=90; } }
if (keyboard_check_pressed(vk_delete)) { delete_save_slot(selected_slot); message="DELETED"; message_timer=90; }
if (message_timer>0) message_timer--;
