/// HP Bar - Create Event

// Smooth display values (store as 0-1 fraction)
display_hp = global.player_hp / max(global.max_player_hp, 1);
display_max_hp = global.max_player_hp;

// Damage trail (red bar behind the green bar)
trail_hp = global.player_hp / max(global.max_player_hp, 1);
trail_speed = 0.015; // how fast the trail catches up

// Bar dimensions
bar_x = 24;
bar_y = display_get_gui_height() - 50;
bar_w = 220;
bar_h = 22;
bar_radius = 6;

// Glow effect
glow_alpha = 0;
glow_pulse = 0;