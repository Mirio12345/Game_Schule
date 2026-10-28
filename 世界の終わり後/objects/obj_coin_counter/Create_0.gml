// obj_coin_counter - Create Event
// HUD counter that displays gold coins in the top-left corner

// Visual properties
coin_size = 8;           // Radius of the coin icon
coin_color = #FFD700;    // Gold color
coin_border_color = #B8860B; // Dark gold border color

// Position on GUI layer (top-left)
gui_x = 20;
gui_y = 20;

// Text properties
text_offset_x = 20;      // X offset from coin icon to text
text_color = c_white;
text_shadow_color = c_black;

// Animation properties
display_value = 0;       // Current displayed value (for counting animation)
target_value = 0;        // Target value to animate towards
count_speed = 5;         // Speed of counting animation