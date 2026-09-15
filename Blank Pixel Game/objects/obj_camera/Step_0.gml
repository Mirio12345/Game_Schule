if (!variable_global_exists("zoom_level_character")) {
	global.zoom_level_character = 1.2;
}
zoom_level = global.zoom_level_character;

// Z ist für den Armor-Perk reserviert. Kamera-Zoom: Q rein, X raus
if (keyboard_check(ord("Q"))) {
    zoom_level -= 0.02;
}
if (keyboard_check(ord("X"))) {
    zoom_level += 0.02;
}

// Clamp zoom so it doesn't flip or get too huge
zoom_level = clamp(zoom_level, 0.3, 2.0);

// Bugfix: ohne diese Zeile wurde zoom_level jeden Frame wieder auf den
// zuletzt gewählten Preset (global.zoom_level_character) zurückgesetzt,
// bevor die Z/X-Änderung gespeichert wurde - Z/X hatten dadurch praktisch
// keinen sichtbaren Dauereffekt.
global.zoom_level_character = zoom_level;

// Apply the new size to the camera
var new_w = default_zoom_width * zoom_level;
var new_h = default_zoom_height * zoom_level;
camera_set_view_size(view_camera[0], new_w, new_h);

// --- 2. CENTER ON CHARACTER ---
if (instance_exists(target)) {
    // Calculate the position to center the camera on the player
    // We subtract half the NEW width/height from the player's position
    var cx = target.x - (new_w / 2);
    var cy = target.y - (new_h / 2);

    // Optional: Clamp to room boundaries so you don't see outside the room
    cx = clamp(cx, 0, room_width - new_w);
    cy = clamp(cy, 0, room_height - new_h);

    // Apply position
    camera_set_view_pos(view_camera[0], cx, cy);
}