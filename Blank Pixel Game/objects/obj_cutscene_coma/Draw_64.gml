/// @description obj_cutscene_coma – Draw GUI Event
/// Draws the black screen overlay, eyelid effect, and dialogue box.
/// Uses Draw GUI so coordinates are in screen space (not room space).

// ============================================================
//  1. SCREEN OVERLAY  (full-screen black rectangle)
// ============================================================
// Draws a black rectangle over the entire GUI area.
// Alpha controlled by screen_alpha (1 = fully black, 0 = transparent).
if (screen_alpha > 0.01) {
    draw_set_alpha(screen_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

// ============================================================
//  2. EYELID EFFECT  (top and bottom bars that open/close)
// ============================================================
// Simulates eyelids by drawing black bars at the top and bottom
// of the screen. The height of each bar is proportional to eyelid_alpha.
// eyelid_alpha = 1 → bars cover entire screen (fully closed)
// eyelid_alpha = 0 → bars are gone (fully open)
if (eyelid_alpha > 0.01) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _eyelid_height = _gui_h * eyelid_alpha; // height of each eyelid bar

    draw_set_alpha(1);
    draw_set_color(eyelid_color);

    // Top eyelid (covers from top down)
    draw_rectangle(0, 0, _gui_w, _eyelid_height, false);

    // Bottom eyelid (covers from bottom up)
    draw_rectangle(0, _gui_h - _eyelid_height, _gui_w, _gui_h, false);
}

// ============================================================
//  3. DIALOGUE BOX  (only shown when dialogue_text is not empty)
// ============================================================
if (dialogue_text != "" && dialogue_box_alpha > 0.01) {
    // --- Dialogue box background ---
    draw_set_alpha(dialogue_box_alpha * dialogue_box_alpha_bg);
    draw_set_color(dialogue_box_color);
    draw_rectangle(
        dialogue_box_x,
        dialogue_box_y,
        dialogue_box_x + dialogue_box_width,
        dialogue_box_y + dialogue_box_height,
        false
    );

    // --- Dialogue box border ---
    draw_set_alpha(dialogue_box_alpha);
    draw_set_color(c_white);
    draw_rectangle(
        dialogue_box_x,
        dialogue_box_y,
        dialogue_box_x + dialogue_box_width,
        dialogue_box_y + dialogue_box_height,
        true  // outline only
    );

    // --- Dialogue text (typewriter effect) ---
    draw_set_alpha(dialogue_box_alpha);
    draw_set_color(dialogue_text_color);
    draw_set_font(dialogue_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // Only draw the characters revealed so far
    var _visible_text = string_copy(dialogue_text, 1, dialogue_char_index);
    draw_text_ext(
        dialogue_box_x + 16,
        dialogue_box_y + 16,
        _visible_text,
        24,  // line spacing
        dialogue_box_width - 32  // max width before wrapping
    );

    // --- "Press Space" prompt (shown when dialogue is complete) ---
    if (dialogue_complete) {
        draw_set_alpha(0.5 + 0.5 * sin(current_time / 300)); // pulsing
        draw_set_color(c_white);
        draw_set_font(dialogue_font);
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_text(
            dialogue_box_x + dialogue_box_width - 16,
            dialogue_box_y + dialogue_box_height - 8,
            "[Space]"
        );
    }

    // Reset draw state
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(c_white);
}