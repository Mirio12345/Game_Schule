/// @description obj_cutscene_coma – Step Event
/// Handles state transitions, input, typewriter effect, eyelid animations,
/// and screen fading. Runs every frame.

// ============================================================
//  INPUT COOLDOWN  (prevent accidental double-advance)
// ============================================================
if (input_cooldown > 0) {
    input_cooldown--;
}

// ============================================================
//  INTERACT INPUT  (Space or generic interact key)
// ============================================================
var _interact_pressed = keyboard_check_pressed(vk_space)
                     || keyboard_check_pressed(vk_enter)
                     || keyboard_check_pressed(ord("E"));

// ============================================================
//  TYPEWRITER EFFECT  (reveal dialogue text character by character)
// ============================================================
if (!dialogue_complete) {
    dialogue_timer += dialogue_char_speed;
    dialogue_char_index = floor(dialogue_timer);
    if (dialogue_char_index >= string_length(dialogue_text)) {
        dialogue_char_index = string_length(dialogue_text);
        dialogue_complete = true;
    }
}

// ============================================================
//  DIALOGUE BOX FADE-IN
// ============================================================
if (dialogue_box_alpha < 1) {
    dialogue_box_alpha = min(dialogue_box_alpha + 0.05, 1);
}

// ============================================================
//  STATE MACHINE
// ============================================================
switch (state) {

    // --------------------------------------------------------
    //  STATE 0 – BLACK SCREEN
    //  "Where... am I?"
    // --------------------------------------------------------
    case 0:
        // Keep screen fully black
        screen_alpha = 1.0;
        screen_target = 1.0;
        eyelid_alpha = 1.0;
        eyelid_target = 1.0;

        // Wait for player input to advance
        if (_interact_pressed && input_cooldown <= 0) {
            input_cooldown = input_cooldown_max;
            // Move to state 1
            state = 1;
            dialogue_index = 1;
            dialogue_text = dialogue_lines[1];
            dialogue_char_index = 0;
            dialogue_timer = 0;
            dialogue_complete = false;
            dialogue_box_alpha = 0;
            // Start blink animation
            blink_active = true;
            blink_timer = 0;
            // Set eyelid target for state 1
            eyelid_target = 0.6;
            screen_target = 0.7;
        }
        break;

    // --------------------------------------------------------
    //  STATE 1 – FIRST EYE OPEN
    //  "My head is pounding..."
    // --------------------------------------------------------
    case 1:
        // Gradually open eyelids and clear screen
        eyelid_alpha = lerp(eyelid_alpha, eyelid_target, eyelid_speed);
        screen_alpha = lerp(screen_alpha, screen_target, screen_fade_speed);

        // Blink animation: eyelids open briefly then close
        if (blink_active) {
            blink_timer++;
            if (blink_timer < blink_half) {
                // Opening phase
                eyelid_alpha = lerp(eyelid_alpha, 0.3, 0.05);
            } else if (blink_timer < blink_duration) {
                // Closing phase
                eyelid_alpha = lerp(eyelid_alpha, eyelid_target, 0.05);
            } else {
                // Blink complete
                blink_active = false;
                eyelid_alpha = eyelid_target;
            }
        }

        // Wait for player input to advance
        if (_interact_pressed && input_cooldown <= 0 && dialogue_complete) {
            input_cooldown = input_cooldown_max;
            // Move to state 2
            state = 2;
            dialogue_index = 2;
            dialogue_text = dialogue_lines[2];
            dialogue_char_index = 0;
            dialogue_timer = 0;
            dialogue_complete = false;
            dialogue_box_alpha = 0;
            // Start blink animation
            blink_active = true;
            blink_timer = 0;
            // Set eyelid target for state 2
            eyelid_target = 0.3;
            screen_target = 0.3;
        }
        break;

    // --------------------------------------------------------
    //  STATE 2 – SECOND EYE OPEN
    //  "I can hear voices... Is that a bazaar?"
    // --------------------------------------------------------
    case 2:
        // Gradually open eyelids wider and clear screen more
        eyelid_alpha = lerp(eyelid_alpha, eyelid_target, eyelid_speed);
        screen_alpha = lerp(screen_alpha, screen_target, screen_fade_speed);

        // Blink animation: eyelids open wider then close
        if (blink_active) {
            blink_timer++;
            if (blink_timer < blink_half) {
                // Opening phase
                eyelid_alpha = lerp(eyelid_alpha, 0.1, 0.05);
            } else if (blink_timer < blink_duration) {
                // Closing phase
                eyelid_alpha = lerp(eyelid_alpha, eyelid_target, 0.05);
            } else {
                // Blink complete
                blink_active = false;
                eyelid_alpha = eyelid_target;
            }
        }

        // Wait for player input to advance
        if (_interact_pressed && input_cooldown <= 0 && dialogue_complete) {
            input_cooldown = input_cooldown_max;
            // Move to state 3
            state = 3;
            // Clear dialogue
            dialogue_text = "";
            dialogue_complete = true;
            dialogue_box_alpha = 0;
            // Set targets for full wake-up
            eyelid_target = 0.0;
            screen_target = 0.0;
        }
        break;

    // --------------------------------------------------------
    //  STATE 3 – FULLY AWAKE
    //  Eyelids fully open, alpha fades to 0, restore control
    // --------------------------------------------------------
    case 3:
        // Fade out eyelids and screen overlay
        eyelid_alpha = lerp(eyelid_alpha, eyelid_target, 0.02);
        screen_alpha = lerp(screen_alpha, screen_target, 0.02);

        // When both are nearly transparent, restore player control and destroy
        if (eyelid_alpha < 0.01 && screen_alpha < 0.01) {
            // Mark intro as played so it won't repeat on respawn/reload
            global.intro_played = true;
            // Restore player movement
            global.can_move = true;
            // Destroy this cutscene controller
            instance_destroy();
        }
        break;
}

// ============================================================
//  SAFETY: Ensure player stays locked during cutscene
// ============================================================
if (state < 3) {
    global.can_move = false;
}