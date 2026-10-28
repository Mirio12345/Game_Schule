/// @description Inventory Controller - Create
/// Handles inventory display when B key is pressed

// Prevent duplicate instances (object is persistent)
if (instance_number(obj_inventory_controller) > 1)
{
    instance_destroy();
    exit;
}

// Inventory state
global.inventory_open = false;

// Inventory slots: array of structs { name, sprite, count, desc, usable }
// The sprite is 778x326 with a 10x4 grid = 40 slots
global.inventory_items = [];

// Grid layout
grid_cols = 10;
grid_rows = 4;
total_slots = grid_cols * grid_rows; // 40

// Slot dimensions (calculated from sprite)
slot_w = 778 / grid_cols;  // ~77.8
slot_h = 326 / grid_rows;  // ~81.5

// Padding inside each slot for item icons
slot_padding = 4;

// Selection state
selected_slot = 0;       // Currently selected slot index
nav_cooldown = 0;        // Prevents too-fast navigation
nav_delay = 8;           // Frames between navigation steps

// Animation
anim_open = 0;          // 0 = closed, 1 = fully open
anim_speed = 0.1;       // How fast the inventory opens/closes

// Feedback message (shown briefly after using an item)
feedback_msg = "";
feedback_timer = 0;

// Mouse hover state
mouse_hover_slot = -1;

// Game paused state
prev_inventory_open = false;
