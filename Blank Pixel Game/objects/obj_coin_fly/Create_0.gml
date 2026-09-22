// obj_coin_fly - Create Event
// Spawns when an enemy dies, flies from enemy position to HUD counter

// Start position (world space - where enemy died)
start_x = x;
start_y = y;

// Convert start position to GUI coordinates for rendering
// Camera position
var _cam = view_camera[0];
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

// Start position in GUI space
start_gui_x = start_x - _cam_x;
start_gui_y = start_y - _cam_y;

// Target position (HUD counter in top-left corner - GUI space)
target_gui_x = 20;
target_gui_y = 20;

// Current position (GUI space - for rendering)
gui_x = start_gui_x;
gui_y = start_gui_y;

// Animation variables
fly_progress = 0;        // 0 to 1 progress
fly_speed = 0.02;        // Speed of travel (adjust for faster/slower)
fly_delay = 0;           // Delay before flying starts (for staggering multiple coins)
fly_arc_height = irandom_range(-30, 30);  // Random arc height for visual variety

// Coin value (number of coins this instance represents)
coin_value = 5;          // Each flying coin represents 5 coins

// Visual properties
alpha = 1;               // Opacity (for fade-out near target)
coin_size = 6;           // Radius of the coin circle
coin_color = #FFD700;    // Gold color
coin_border_color = #B8860B; // Dark gold border color

// State tracking
is_arrived = false;      // Whether the coin has reached its target