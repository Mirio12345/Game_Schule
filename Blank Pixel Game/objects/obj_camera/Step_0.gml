
// Zoom in with 'Z', Zoom out with 'X'
if (keyboard_check(ord("Z"))) {
    zoom_level -= 0.01;
}
if (keyboard_check(ord("X"))) {
    zoom_level += 0.01;
}

// Clamp zoom so it doesn't flip or get too huge
zoom_level = clamp(zoom_level, 0.1, 5.0);

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