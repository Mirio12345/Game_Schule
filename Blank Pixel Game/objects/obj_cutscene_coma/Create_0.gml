/// @description obj_cutscene_coma – Create Event
/// Initializes all state variables for the "waking up from a coma" cutscene.
/// Place this object in the room where the cutscene should play.

// ============================================================
//  SKIP IF ALREADY PLAYED  (e.g. on room restart / respawn)
// ============================================================
if (variable_global_exists("intro_played") && global.intro_played == true) {
    // Cutscene already seen – restore control and destroy immediately
    global.can_move = true;
    instance_destroy();
    exit;
}

// ============================================================
//  STATE MACHINE
// ============================================================
// 0 = Black Screen        – "Where... am I?"
// 1 = First Eye Open      – "My head is pounding..."
// 2 = Second Eye Open     – "I can hear voices... Is that a bazaar?"
// 3 = Fully Awake         – Eyelids fully open, fade out, restore control
// ============================================================
state = 0;

// ============================================================
//  DIALOGUE LINES  (one per state)
// ============================================================
dialogue_lines = [
    "Where... am I?",
    "My head is pounding...",
    "I can hear voices... Is that a bazaar?"
];

// Current dialogue index (matches state 0-2)
dialogue_index = 0;

// ============================================================
//  DIALOGUE DISPLAY
// ============================================================
dialogue_text       = dialogue_lines[0];   // text currently shown
dialogue_char_index = 0;                    // typewriter: how many chars revealed
dialogue_char_speed = 0.5;                  // characters per frame (adjust for speed)
dialogue_timer      = 0;                    // frame counter for typewriter
dialogue_complete   = false;                // true when full line is shown
dialogue_box_alpha  = 0;                    // fade-in for the dialogue box

// ============================================================
//  EYELID / VISION SYSTEM
// ============================================================
// eyelid_alpha: 1 = fully closed (black), 0 = fully open
// Each state opens the eyelids a bit more.
eyelid_alpha       = 1.0;   // start fully black
eyelid_target      = 1.0;   // target alpha for current state
eyelid_speed       = 0.008; // how fast eyelids open/close per frame

// Eyelid "blink" animation (open then close briefly)
blink_active       = false;
blink_timer        = 0;
blink_duration     = 40;    // frames for a full blink cycle
blink_half         = 20;    // frames to open, then close

// ============================================================
//  SCREEN FADE / OVERLAY
// ============================================================
// Overall screen overlay alpha (1 = black, 0 = transparent)
screen_alpha       = 1.0;
screen_target      = 1.0;
screen_fade_speed  = 0.01;

// ============================================================
//  PLAYER CONTROL LOCK
// ============================================================
// Disable player movement during the cutscene
global.can_move = false;

// ============================================================
//  INPUT COOLDOWN  (prevent accidental double-advance)
// ============================================================
input_cooldown     = 0;
input_cooldown_max = 15;   // frames to wait before accepting next input

// ============================================================
//  TIMING / TRANSITION
// ============================================================
// Delay before auto-advancing (in frames) – set to -1 to require input
auto_advance_delay = -1;   // -1 = manual only
auto_advance_timer = 0;

// Transition speed between states (frames to wait)
state_transition_delay = 30;  // frames to wait after dialogue before next state
state_transition_timer = 0;
transitioning          = false;

// ============================================================
//  VISUAL SETTINGS
// ============================================================
// Dialogue box appearance
dialogue_box_x      = 40;   // x position (GUI coordinates)
dialogue_box_y      = 480;   // y position (GUI coordinates)
dialogue_box_width  = 720;   // width of dialogue box
dialogue_box_height = 120;   // height of dialogue box
dialogue_box_color  = c_black;
dialogue_box_alpha_bg = 0.75; // background alpha
dialogue_text_color = c_white;
dialogue_font       = Main_menu_font; // use existing font

// Eyelid colors
eyelid_color        = c_black;

// ============================================================
//  STATE DESCRIPTIONS (for debugging / comments)
// ============================================================
// state 0: Black screen, dialogue "Where... am I?"
//   - screen_alpha = 1 (fully black)
//   - eyelid_alpha = 1 (fully closed)
//   - After player presses Space → transition to state 1
//
// state 1: First eye open
//   - screen_alpha fades to ~0.7
//   - eyelid_alpha opens to ~0.6 (slight opening)
//   - Blink animation: eyelids open briefly then close
//   - Dialogue: "My head is pounding..."
//   - After player presses Space → transition to state 2
//
// state 2: Second eye open
//   - screen_alpha fades to ~0.3
//   - eyelid_alpha opens to ~0.3 (wider opening)
//   - Blink animation: eyelids open wider then close
//   - Dialogue: "I can hear voices... Is that a bazaar?"
//   - After player presses Space → transition to state 3
//
// state 3: Fully awake
//   - screen_alpha fades to 0
//   - eyelid_alpha fades to 0
//   - global.can_move = true
//   - Destroy self